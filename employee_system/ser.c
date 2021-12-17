#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <string.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <string.h>
#include <stdlib.h>
#include <sqlite3.h>
#include <time.h>
#include "ser.h"

struct cliall{
	struct sockaddr_in cin;
	int newfd;
};
sqlite3 *db = NULL;

//员工注册
int do_register(int newfd)
{
	char *errmsg;
	bzero(sql,sizeof(sql));
	char workno[20] = "0";
	sprintf(sql,"insert into account_table values(\"%s\",\"%s\",\"%s\",%d);",mes_buf.account_name,mes_buf.passwd,workno,0);
	if(sqlite3_exec(db,sql,NULL,NULL,&errmsg) != 0)
	{
		printf("%s\n",errmsg);
		if(strcmp(errmsg,"UNIQUE constraint failed: account_table.account_name") == 0)
		{
			mes_buf.type = 'E';
			send(newfd,&mes_buf,sizeof(mes_buf),0);
		}
		else
		{
			ERR_MSG("sqlite3_exec");
			return -1;
		}
	}
	else
		send(newfd,&mes_buf,sizeof(mes_buf),0);

	return 0;
}

//员工权限
int employee_add(int newfd)
{
	recv(newfd,&emp_buf,sizeof(emp_buf),0);
	//增加一次信息
	bzero(sql,sizeof(sql));
	sprintf(sql,"select * from account_table where account_name=\"%s\" and passwd=\"%s\";",mes_buf.account_name,mes_buf.passwd);	
	char *errmsg = NULL;
	char **pres = NULL; 
	int row,column;
	sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg);
	if(strcmp(pres[(row+1)*column-2],"0") != 0)
	{
		mes_buf.type = 'e';
		send(newfd,&mes_buf,sizeof(mes_buf),0);
		return -1;
	}	
	//增加自己的信息
	bzero(sql,sizeof(sql));
	sprintf(sql,"insert into employee_table values(\"%s\", \"%s\", %d, \"%s\" ,%f, \"%s\", \"%s\");",emp_buf.name,emp_buf.sex,emp_buf.age,emp_buf.address,emp_buf.salary,emp_buf.wkno,emp_buf.phone);
	if(sqlite3_exec(db,sql,NULL,NULL,&errmsg) != 0)
	{
		printf("%s\n",errmsg);

		if(strcmp(errmsg,"UNIQUE constraint failed: employee_table.wkno") == 0)
		{
			mes_buf.type = 'E';
			send(newfd,&mes_buf,sizeof(mes_buf),0);
			return -1;
		}
		else
		{
			ERR_MSG("sqlite3_exec");
			return -1;
		}
	}
	else
		send(newfd,&mes_buf,sizeof(mes_buf),0);
	//工号与账号绑定,员工只能修改自己的信息
	bzero(sql, N);
	sprintf(sql, "update account_table set workno=\"%s\" where account_name=\"%s\" ;",emp_buf.wkno,mes_buf.account_name);
	sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	
	return 0;
}

//员工修改
int employee_modif(int newfd)
{
	recv(newfd,&emp_buf,sizeof(emp_buf),0);
	
	char sql[N] = {0};
	sprintf(sql,"select * from account_table where account_name=\"%s\" and passwd=\"%s\";",mes_buf.account_name,mes_buf.passwd);
	
	char *errmsg = NULL;
	char **pres = NULL; 
	int row,column;
	sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg);	
	//printf("%s\n",pres[(row+1)*column-2]);
	if(strcmp(pres[(row+1)*column-2],emp_buf.wkno) != 0)
	{	
		mes_buf.type = 'E';
	//	printf("只能修改自己的信息\n");
	}
	else
	{
		bzero(sql,sizeof(sql));
		sprintf(sql,"update employee_table set name=\"%s\",age=%d,address=\"%s\",phone=\"%s\" where wkno=\"%s\";",emp_buf.name,emp_buf.age,emp_buf.address,emp_buf.phone,emp_buf.wkno);
		printf("%s\n",sql);
		sqlite3_exec(db,sql,NULL,NULL,&errmsg);	
	}
	send(newfd,&mes_buf,sizeof(mes_buf),0);

	return 0;
}
int employee_search(int newfd)
{
	recv(newfd,&emp_buf,sizeof(emp_buf),0);
	char sql[N] = {0};
	sprintf(sql,"select * from employee_table where wkno=\"%s\";",emp_buf.wkno);
	
	char *errmsg = NULL;
	char **pres = NULL; 
	int row,column;
	sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg);	
	if(0 == row)
	{
		mes_buf.type = 'E';
		send(newfd,&mes_buf,sizeof(mes_buf),0);
	}
	else
	{
		send(newfd,&mes_buf,sizeof(mes_buf),0);
		char sql1[N] = {0};
		sprintf(sql1,"select * from account_table where account_name=\"%s\" and passwd=\"%s\";",mes_buf.account_name,mes_buf.passwd);
		sqlite3_get_table(db,sql1,&pres,&row,&column,&errmsg);	
		printf("%s\n",pres[(row+1)*column-2]);
		if(strcmp(pres[(row+1)*column-2],emp_buf.wkno) != 0)
		{	
			bzero(sql,sizeof(sql));
			sprintf(sql,"select * from employee_table where wkno=\"%s\";",emp_buf.wkno);
			sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg);	
			memset(&emp_buf,0,sizeof(emp_buf));
			strcpy(emp_buf.name,pres[(row+column-1)]);
			strcpy(emp_buf.sex,pres[(row+column-1)+1]);
			strcpy(emp_buf.wkno,pres[(row+column-1)+5]);
			strcpy(emp_buf.phone,pres[(row+column-1)+6]);	
			send(newfd,&emp_buf,sizeof(emp_buf),0);
			memset(&emp_buf,0,sizeof(emp_buf));
		}
		else
		{
			bzero(sql,sizeof(sql));
			sprintf(sql,"select * from employee_table where wkno=\"%s\";",emp_buf.wkno);
			sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg);	
			memset(&emp_buf,0,sizeof(emp_buf));
			strcpy(emp_buf.name,pres[(row+column-1)]);
			strcpy(emp_buf.sex,pres[(row+column-1)+1]);
			emp_buf.age = atoi(pres[(row*column)+2]);
			strcpy(emp_buf.address,pres[(row+column-1)+3]);
			emp_buf.salary = atoi(pres[(row+column-1)+4]);
			strcpy(emp_buf.wkno,pres[(row+column-1)+5]);
			strcpy(emp_buf.phone,pres[(row+column-1)+6]);	
			send(newfd,&emp_buf,sizeof(emp_buf),0);
			memset(&emp_buf,0,sizeof(emp_buf));
		}
	}
	return 0;
}

//员工退出
int do_back(int newfd)
{
	char *errmsg = NULL;
	bzero(sql, N);
	sprintf(sql, "update account_table set flag = 0 where account_name=\"%s\" ;", 
			mes_buf.account_name);
	if(sqlite3_exec(db, sql, NULL, NULL, &errmsg) != 0)
	{
		printf("sqlite3_exec:%s %d\n", errmsg, __LINE__);
		return -1;
	}
	return 0;
}

//员工登录
int employee_load(int newfd)
{
	char sql[N] = {0};
	sprintf(sql,"select * from account_table where account_name=\"%s\" and passwd=\"%s\";",mes_buf.account_name,mes_buf.passwd);
	char *errmsg = NULL;
	char **pres = NULL; 
	int row,column;
	if(sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg) != 0)
	{
		printf("sqlite3_exec:%s %d\n", errmsg, __LINE__);
		return -1;
	}
	if(0 == row)
	{
		mes_buf.type = 'N';
	}
	else
	{
		//判断状态是否已经登录
		if(strcmp(pres[(row+1)*column-1], "0") == 0) 	//未登录状态
		{
			mes_buf.type = 'O';
			//将状态设置位已经登录状态 flag =1;
			bzero(sql, N);
			sprintf(sql, "update account_table set flag = 1 where account_name=\"%s\" ;", mes_buf.account_name);
			if(sqlite3_exec(db, sql, NULL, NULL, &errmsg) != 0)
			{
				printf("sqlite3_exec:%s %d\n", errmsg, __LINE__);
				return -1;
			}
		}
		else
		{
			mes_buf.type = 'E';//已登录状态
			bzero(mes_buf.account_name,sizeof(mes_buf.account_name));//登录异常后，
			//清空名字
		}
	}
	send(newfd,&mes_buf,sizeof(mes_buf),0);
	return 0;
}

//管理员登录
int admin_load(int newfd)
{
	char sql[N] = {0};
	sprintf(sql,"select * from admin_table where admin_name=\"%s\" and passwd=\"%s\";",mes_buf.account_name,mes_buf.passwd);
	char *errmsg = NULL;
	char **pres = NULL; 
	int row,column;
	if(sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg) != 0)
	{
		printf("sqlite3_exec:%s %d\n", errmsg, __LINE__);
		return -1;
	}
	if(0 == row)
	{
		mes_buf.type = 'N';
	}
	else
	{
		//判断状态是否已经登录
		if(strcmp(pres[(row+1)*column-1], "0") == 0) 	//未登录状态
		{
			mes_buf.type = 'O';
			//将状态设置位已经登录状态 flag =1;
			bzero(sql, N);
			sprintf(sql, "update admin_table set flag = 1 where admin_name=\"%s\" ;", mes_buf.account_name);
			if(sqlite3_exec(db, sql, NULL, NULL, &errmsg) != 0)
			{
				printf("sqlite3_exec:%s %d\n", errmsg, __LINE__);
				return -1;
			}
		}
		else
		{
			mes_buf.type = 'E';//已登录状态
			bzero(mes_buf.account_name,sizeof(mes_buf.account_name));//登录异常后，
			//清空名字
		}
	}
	send(newfd,&mes_buf,sizeof(mes_buf),0);
	return 0;
}

//管理员增加权限
int admin_add(int newfd)
{
	char *errmsg;
	
	recv(newfd,&emp_buf,sizeof(emp_buf),0);
	
	bzero(sql,sizeof(sql));
	sprintf(sql,"insert into employee_table values(\"%s\", \"%s\", %d, \"%s\" ,%f, \"%s\", \"%s\");",emp_buf.name,emp_buf.sex,emp_buf.age,emp_buf.address,emp_buf.salary,emp_buf.wkno,emp_buf.phone);
	
	if(sqlite3_exec(db,sql,NULL,NULL,&errmsg) != 0)
	{
		printf("%s\n",errmsg);

		if(strcmp(errmsg,"UNIQUE constraint failed: employee_table.wkno") == 0)
		{
			mes_buf.type = 'E';
			send(newfd,&mes_buf,sizeof(mes_buf),0);
			return -1;
		}
		else
		{
			ERR_MSG("sqlite3_exec");
			return -1;
		}
	}
	else
		send(newfd,&mes_buf,sizeof(mes_buf),0);

	return 0;
}

//管理员删除权限
int admin_del(int newfd)
{
	recv(newfd,&emp_buf,sizeof(emp_buf),0);
	char sql[N] = {0};
	sprintf(sql,"select * from employee_table where wkno=\"%s\";",emp_buf.wkno);
	
	char *errmsg = NULL;
	char **pres = NULL; 
	int row,column;
	sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg);	
	if(0 == row)
	{
		mes_buf.type = 'E';
	}
	else
	{
		bzero(sql,sizeof(sql));
		sprintf(sql,"delete from employee_table where wkno=\"%s\";",emp_buf.wkno);
		printf("%s\n",sql);
		sqlite3_exec(db,sql,NULL,NULL,&errmsg);
	}
	
	send(newfd,&mes_buf,sizeof(mes_buf),0);

	return 0;
}

//管理员修改权限
int admin_modif(int newfd)
{
	recv(newfd,&emp_buf,sizeof(emp_buf),0);
	char sql[N] = {0};
	sprintf(sql,"select * from employee_table where wkno=\"%s\";",emp_buf.wkno);
	
	char *errmsg = NULL;
	char **pres = NULL; 
	int row,column;
	sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg);	
	if(0 == row)
	{
		mes_buf.type = 'E';
		send(newfd,&mes_buf,sizeof(mes_buf),0);
	}
	else
	{
		send(newfd,&mes_buf,sizeof(mes_buf),0);
		recv(newfd,&emp_buf,sizeof(emp_buf),0);
		bzero(sql,sizeof(sql));
		sprintf(sql,"update employee_table set name=\"%s\",sex=\"%s\",age=%d,address=\"%s\",salary=%f,phone=\"%s\" where wkno=\"%s\";",emp_buf.name,emp_buf.sex,emp_buf.age,emp_buf.address,emp_buf.salary,emp_buf.phone,emp_buf.wkno);
		sqlite3_exec(db,sql,NULL,NULL,&errmsg);
	}

	return 0;
}

//管理员查询
int admin_search(int newfd)
{
	recv(newfd,&emp_buf,sizeof(emp_buf),0);
	char sql[N] = {0};
	sprintf(sql,"select * from employee_table where wkno=\"%s\";",emp_buf.wkno);
	
	char *errmsg = NULL;
	char **pres = NULL; 
	int row,column;
	sqlite3_get_table(db,sql,&pres,&row,&column,&errmsg);	
	if(0 == row)
	{
		mes_buf.type = 'E';
		send(newfd,&mes_buf,sizeof(mes_buf),0);
	}
	else
	{
		send(newfd,&mes_buf,sizeof(mes_buf),0);
		
		strcpy(emp_buf.name,pres[(row+column-1)]);
		strcpy(emp_buf.sex,pres[(row*column)+1]);
		emp_buf.age = atoi(pres[(row*column)+2]);
		strcpy(emp_buf.address,pres[(row+column-1)+3]);
		emp_buf.salary = atoi(pres[(row+column-1)+4]);
		strcpy(emp_buf.wkno,pres[(row+column-1)+5]);
		strcpy(emp_buf.phone,pres[(row+column-1)+6]);
		
		send(newfd,&emp_buf,sizeof(emp_buf),0);
		memset(&emp_buf,0,sizeof(emp_buf));
	}
	return 0;
}

//管理员账号退出
int admin_back(int newfd)
{
	char *errmsg = NULL;
	bzero(sql, N);
	sprintf(sql, "update admin_table set flag = 0 where admin_name=\"%s\" ;", 
			mes_buf.account_name);
	if(sqlite3_exec(db, sql, NULL, NULL, &errmsg) != 0)
	{
		printf("sqlite3_exec:%s %d\n", errmsg, __LINE__);
		return -1;
	}
	return 0;
}

//分支线程
void* rcv_cli_msg(void* arg)
{
	pthread_detach(pthread_self());

	struct cliall cli_msg = *(struct cliall*)arg;
	int newfd = cli_msg.newfd;
	ssize_t res=0;

	while(1)
	{
		res = recv(newfd,&mes_buf,sizeof(mes_buf),0);//通讯接收
		if(res < 0)
		{
			printf("%ld\n",res);
			ERR_MSG("recv");
		}
		else if(res == 0)
		{
			printf("%d关闭\n",newfd);
			pthread_exit(NULL);
		}
		switch(mes_buf.type)
		{
		case 'R':
			do_register(newfd);
			break;
		case 'L':
			employee_load(newfd);
			break;
		case 'A':
			employee_add(newfd);
			break;
		case 'I':
			employee_modif(newfd);
			break;
		case 'S':
			employee_search(newfd);
			break;
		case 'B':
			do_back(newfd);
			break;
		case 'M':
			admin_load(newfd);
			break;
		case 'a':
			admin_add(newfd);
			break;
		case 'd':
			admin_del(newfd);
			break;
		case 'i':
			admin_modif(newfd);
			break;
		case 's':
			admin_search(newfd);
			break;
		case 'b':
			admin_back(newfd);
			break;
		default:
			printf("主菜单：请重新输入\n");
		}
	}

	close(newfd);
	pthread_exit(NULL);
}

//网络初始化
int init_net()
{
	//创建套接字，返回文件描述符
	int sfd = socket(AF_INET,SOCK_STREAM,0);
	if(sfd < 0){
		ERR_MSG("socket");
		return -1;
	}
	//允许端口快速重用
	int reuse = 1;
	if(setsockopt(sfd,SOL_SOCKET,SO_REUSEADDR,&reuse,sizeof(int)) < 0){
		ERR_MSG("setsockopt");
		return -1;
	}
	//绑定ip和端口号,转换为网络字节序后绑定
	struct sockaddr_in sin;
	sin.sin_family      = AF_INET;      //ipv4
	sin.sin_port        = htons(PORT);  //端口号的网络字节序
	sin.sin_addr.s_addr = inet_addr(IP);//ip地址的网络字节序
	if(bind(sfd,(struct sockaddr*)&sin,sizeof(sin)) < 0)
	{
		ERR_MSG("bind");
		return -1;
	}
	//将套接字设置为被动监听状态,10-未链接的列队大小
	if(listen(sfd,10) < 0)
	{
		ERR_MSG("listen");
		return -1;
	}
	printf("设置监听成功\n");

	struct sockaddr_in cin;
	socklen_t addrlen = sizeof(cin);

	pthread_t tid;
	int newfd;
	struct cliall cli_msg;
	while(1)
	{
		//获取连接成功后的套接字
		newfd = accept(sfd,(struct sockaddr*)&cin,&addrlen);
		if(newfd < 0)
		{
			ERR_MSG("accept");
			return -1;
		}
		printf("newfd=%d \n",newfd);
		cli_msg.newfd = newfd;
		cli_msg.cin=cin;

		pthread_create(&tid,NULL,rcv_cli_msg,(void*)&cli_msg);
	}

}

//创建数据库
int create_mydatebase()
{
	char *errmsg = NULL;
	//打开数据库
	if(sqlite3_open("./my.db", &db) != SQLITE_OK)
	{
		fprintf(stderr, "%s\n", sqlite3_errmsg(db));
		return -1;
	}
	printf("打开数据库\n");

	//创建员工账户表，员工表,管理员账户表
	char sql1[N] = "create table if not exists account_table(account_name char primary key,passwd char,workno char,flag int)";
	sqlite3_exec(db,sql1,NULL,NULL,&errmsg);
	
	char sql3[N] = "create table if not exists admin_table(admin_name char primary key,passwd char,flag int)";
	sqlite3_exec(db,sql3,NULL,NULL,&errmsg);
	bzero(sql,sizeof(sql));
	sprintf(sql,"insert into admin_table values('admin1','123456',0);");
	sqlite3_exec(db,sql,NULL,NULL,&errmsg);
	bzero(sql,sizeof(sql));
	sprintf(sql,"insert into admin_table values('admin2','000000',0);");
	sqlite3_exec(db,sql,NULL,NULL,&errmsg);
	
	char sql2[N] = "create table if not exists employee_table(name char,sex char,age int,address char,salary float,wkno char primary key,phone char)";	
	sqlite3_exec(db,sql2,NULL,NULL,&errmsg);

	printf("创建表成功\n");
	return 0;
}

int main(int argc, const char *argv[])
{
	int sfd;
	char *errmsg = NULL;
	
	create_mydatebase();
	
	//所有账户置位
	bzero(sql, N);
	sprintf(sql, "update admin_table set flag = 0;");
	sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	bzero(sql, N);
	sprintf(sql, "update account_table set flag = 0;");
	sqlite3_exec(db, sql, NULL, NULL, &errmsg);

	sfd = init_net();
		
	close(sfd);
	return 0;
}
