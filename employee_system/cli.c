#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <signal.h>
#include "cli.h"
/*
   struct employee{
   char type;
   char name[20];
   char sex;
   int age;
   char address[128];	
   float salary;
   int wkno;
   char phone[128];
   };
   */
int sockfd = 0;
int flag = 0;
typedef void(*sighandler_t)(int);
void handler(int sig)
{
	if(flag == 0)
		do_back(sockfd);
	else
		do_back_admin(sockfd);
	close(sockfd);
	exit(0);
}
//网络初始化
int init_net()
{
	//创建套接字
	int sfd = socket(AF_INET,SOCK_STREAM,0);
	if(sfd < 0){
		ERR_MSG("socket");
		return -1;
	}
	//允许端口快速重用
	int reuse = 1;
	if(setsockopt(sfd,SOL_SOCKET,SO_REUSEADDR,&reuse,sizeof(int)) < 0)
	{
		ERR_MSG("setsockopt");
		return -1;
	}
	//连接服务器
	struct sockaddr_in cin;
	cin.sin_family 		= AF_INET;
	cin.sin_port 		= htons(PORT);
	cin.sin_addr.s_addr = inet_addr(IP);
	if(connect(sfd,(struct sockaddr*)&cin,sizeof(cin)) < 0){
		ERR_MSG("connect");
		return -1;
	}
	printf("连接成功\n");
	return sfd;

}
//注册
int do_register(int sfd)
{
	printf("注册\n");
	mes_buf.type = 'R';
	printf("请输入账户名>>>");
	if(scanf("%s",mes_buf.account_name)){};
	getchar();
	printf("请输入密码>>>");
	if(scanf("%s",mes_buf.passwd)){};
	getchar();
	if(send(sfd,&mes_buf,sizeof(mes_buf),0) < 0)
	{
		ERR_MSG("send");
		return -1;
	}

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'E')
	{
		printf("账户名重复,请重新输入\n");
	}
	else
	{
		printf("用户注册成功\n");
	}
	return 0;
}
//员工增
int do_add(int sfd)
{
	mes_buf.type = 'A';
	send(sfd,&mes_buf,sizeof(mes_buf),0);
	printf("请输入个人信息\n");
	printf("姓名>>>");
	scanf("%s",emp_buf.name);
	getchar();
	printf("性别>>>");
	scanf("%s",emp_buf.sex);
	getchar();
	printf("年龄>>>");
	scanf("%d",&emp_buf.age);
	getchar();
	printf("住址>>>");
	scanf("%s",emp_buf.address);
	getchar();
	printf("薪资>>>");
	scanf("%f",&emp_buf.salary);
	getchar();
	printf("工号>>>");
	scanf("%s",emp_buf.wkno);
	getchar();
	printf("手机号>>>");
	scanf("%s",emp_buf.phone);
	getchar();

	send(sfd,&emp_buf,sizeof(emp_buf),0);

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'E')
	{
		printf("工号重复,请重新输入\n");
	}
	else if(mes_buf.type == 'e')
	{
		printf("只能增加一次自己的信息\n");
	}
	else
	{
		printf("员工信息增加成功\n");	
	}
	return 0;
}
int do_modi_info(int sfd)
{
	mes_buf.type = 'I';
	send(sfd,&mes_buf,sizeof(mes_buf),0);
	printf("请输入你的工号>>>");
	scanf("%s",emp_buf.wkno);
	getchar();
	printf("请输入个人信息\n");
	printf("姓名>>>");
	scanf("%s",emp_buf.name);
	getchar();
	printf("年龄>>>");
	scanf("%d",&emp_buf.age);
	getchar();
	printf("住址>>>");
	scanf("%s",emp_buf.address);
	getchar();
	printf("手机号>>>");
	scanf("%s",emp_buf.phone);
	getchar();

	send(sfd,&emp_buf,sizeof(emp_buf),0);

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'E')
	{
		printf("只能修改自己的信息\n");
	}
	else
	{
		printf("员工信息修改成功\n");
	}

	return 0;
}
int do_search_info(int sfd)
{	
	mes_buf.type = 'S';
	send(sfd,&mes_buf,sizeof(mes_buf),0);
	printf("请输入查询的工号>>>");
	scanf("%s",emp_buf.wkno);
	getchar();

	send(sfd,&emp_buf,sizeof(emp_buf),0);

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'E')
	{
		printf("工号不存在\n");
	}
	else
	{
		printf("查找信息结果如下\n");
		memset(&emp_buf,0,sizeof(emp_buf));
		recv(sfd,&emp_buf,sizeof(emp_buf),0);
		printf("姓名:%s性别:%s年龄:%d住址:%s薪资:%0.2f工号:%s手机号:%s\n",
				emp_buf.name,emp_buf.sex,emp_buf.age,emp_buf.address,
				emp_buf.salary,emp_buf.wkno,emp_buf.phone);	
	}
	
	return 0;
}
//员工登录
int employee_load(int sfd)
{
	mes_buf.type = 'L';
	printf("请输入登录信息\n");
	printf("登录账户名>>>");
	scanf("%s",mes_buf.account_name);
	getchar();
	printf("登录密码>>>");
	scanf("%s",mes_buf.passwd);
	getchar();
	if(send(sfd,&mes_buf,sizeof(mes_buf),0) < 0)
	{
		ERR_MSG("send");
		return -1;
	}

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);	
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'N')
	{
		printf("该用户不存在或者密码错误\n\n");
		return -1;
	}
	else if(mes_buf.type == 'E')
	{
		printf("%s已被登录\n\n",mes_buf.account_name);
		return -1;
	}
	else
	{
		printf("%s登录成功\n\n",mes_buf.account_name);
		while(1)
		{
			int chose;
			printf("**************员工**************\n");
			printf("*****1.增 2.改 3.查 4.返回******\n");
			printf("********************************\n");
			printf("input>>>");
			scanf("%d",&chose);
			while(getchar() != 10);
			switch(chose)
			{
			case 1:
				do_add(sfd);
				break;
			case 2:
				do_modi_info(sfd);
				break;
			case 3:
				do_search_info(sfd);
				break;
			case 4:
				do_back(sfd);
				return 0;
			default:
				printf("请重新输入\n");
			}
		}
	}

	return 0;
}
int do_back(int sfd)
{
	mes_buf.type = 'B';
	if(send(sfd,&mes_buf,sizeof(mes_buf),0) < 0)
	{
		ERR_MSG("send");
		return -1;
	}
	return 0;
}
//管理员登录
int admin_load(int sfd)
{
	mes_buf.type = 'M';
	printf("请输入管理员登录信息\n");
	printf("管理员账户名>>>");
	scanf("%s",mes_buf.account_name);
	getchar();
	printf("管理员密码>>>");
	scanf("%s",mes_buf.passwd);
	getchar();
	if(send(sfd,&mes_buf,sizeof(mes_buf),0) < 0)
	{
		ERR_MSG("send");
		return -1;
	}

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);	
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'N')
	{
		printf("该管理员账户不存在或者密码错误\n\n");
		return -1;
	}
	else if(mes_buf.type == 'E')
	{
		printf("%s管理员已被登录\n\n",mes_buf.account_name);
		return -1;
	}
	else
	{
		printf("%s管理员登录成功\n\n",mes_buf.account_name);
		while(1)
		{
			int chose;
			printf("**************管理员*****************\n");
			printf("*****1.增 2.删 3.改 4.查 5.返回******\n");
			printf("*************************************\n");
			printf("input>>>");
			scanf("%d",&chose);
			while(getchar() != 10);
			switch(chose)
			{
			case 1:
				do_add_admin(sfd);
				break;
			case 2:
				do_del_info_admin(sfd);
				break;
			case 3:
				do_modi_info_admin(sfd);
				break;
			case 4:
				do_search_info_admin(sfd);
				break;
			case 5:
				do_back_admin(sfd);
				return 0;
			default:
				printf("请重新输入\n");
			}
		}
	}
	return 0;
}
int do_add_admin(int sfd)
{
	mes_buf.type = 'a';
	send(sfd,&mes_buf,sizeof(mes_buf),0);
	printf("请输入员工信息\n");
	printf("姓名>>>");
	scanf("%s",emp_buf.name);
	getchar();
	printf("性别>>>");
	scanf("%s",emp_buf.sex);
	getchar();
	printf("年龄>>>");
	scanf("%d",&emp_buf.age);
	getchar();
	printf("住址>>>");
	scanf("%s",emp_buf.address);
	getchar();
	printf("薪资>>>");
	scanf("%f",&emp_buf.salary);
	getchar();
	printf("工号>>>");
	scanf("%s",emp_buf.wkno);
	getchar();
	printf("手机号>>>");
	scanf("%s",emp_buf.phone);
	getchar();

	send(sfd,&emp_buf,sizeof(emp_buf),0);

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'E')
	{
		printf("工号已存在,请重新输入\n");
	}
	else
	{
		printf("员工信息增加成功\n");
	}
	return 0;
}
int do_del_info_admin(int sfd)
{
	mes_buf.type = 'd';
	send(sfd,&mes_buf,sizeof(mes_buf),0);
	printf("请输入需要删除的工号>>>");
	scanf("%s",emp_buf.wkno);
	getchar();
	send(sfd,&emp_buf,sizeof(emp_buf),0);

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'E')
	{
		printf("工号不存在\n");
	}
	else
	{
		printf("已删除\n");
	}

	return 0;
}
int do_modi_info_admin(int sfd)
{
	mes_buf.type = 'i';
	send(sfd,&mes_buf,sizeof(mes_buf),0);
	printf("请输入需要修改的员工工号>>>");
	scanf("%s",emp_buf.wkno);
	getchar();
	send(sfd,&emp_buf,sizeof(emp_buf),0);

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'E')
	{
		printf("工号不存在\n");
	}
	else
	{
		printf("请输入修改信息\n");
		printf("姓名>>>");
		scanf("%s",emp_buf.name);
		getchar();
		printf("性别>>>");
		scanf("%s",emp_buf.sex);
		getchar();
		printf("年龄>>>");
		scanf("%d",&emp_buf.age);
		getchar();
		printf("地址>>>");
		scanf("%s",emp_buf.address);
		getchar();
		printf("薪资>>>");
		scanf("%f",&emp_buf.salary);
		getchar();
		printf("手机号>>>");
		scanf("%s",emp_buf.phone);
		getchar();
		send(sfd,&emp_buf,sizeof(emp_buf),0);
		printf("员工信息修改成功\n");
	}

	return 0;
}
int do_search_info_admin(int sfd)
{
	mes_buf.type = 's';
	send(sfd,&mes_buf,sizeof(mes_buf),0);
	printf("请输入查询的工号>>>");
	scanf("%s",emp_buf.wkno);
	getchar();

	send(sfd,&emp_buf,sizeof(emp_buf),0);

	int res = recv(sfd,&mes_buf,sizeof(mes_buf),0);
	if(res < 0)
	{
		ERR_MSG("recv");
		return -1;
	}
	else if(res == 0)
	{
		printf("服务器关闭\n");
		return -1;
	}
	if(mes_buf.type == 'E')
	{
		printf("工号不存在\n");
	}
	else
	{
		printf("查找信息结果如下\n");
		memset(&emp_buf,0,sizeof(emp_buf));
		recv(sfd,&emp_buf,sizeof(emp_buf),0);
		printf("姓名:%s性别:%s年龄:%d住址:%s薪资:%0.2f工号:%s手机号:%s\n",
				emp_buf.name,emp_buf.sex,emp_buf.age,emp_buf.address,
				emp_buf.salary,emp_buf.wkno,emp_buf.phone);		
	}
	return 0;
}
int do_back_admin(int sfd)
{
	mes_buf.type = 'b';
	if(send(sfd,&mes_buf,sizeof(mes_buf),0) < 0)
	{
		ERR_MSG("send");
		return -1;
	}
	return 0;
}
//登录选择
int do_load(int sfd)
{
	while(1)
	{
		int chose;
		printf("********************************\n");
		printf("***1.普通员工 2.管理员 3.返回***\n");
		printf("********************************\n");
		printf("input>>>");
		scanf("%d",&chose);
		while(getchar() != 10);
		switch(chose)
		{
		case 1:
			//增改查
			flag = 0;
			employee_load(sfd);
			break;
		case 2:
			//增删改查
			flag = 1;
			admin_load(sfd);
			break;
		case 3:
			return 0;
		default:
			printf("请重新输入\n");
		}
	}
	return 0;
}
void do_picture(int sfd)
{
	while(1){
		int chose;
		printf("***欢迎进入员工管理系统***\n");
		printf("**************************\n");
		printf("***1.注册 2.登录 3.退出***\n");
		printf("**************************\n");
		printf("input>>>");
		scanf("%d",&chose);
		while(getchar() != 10);
		switch(chose){
		case 1:
			do_register(sfd);
			break;
		case 2:
			do_load(sfd);
			break;
		case 3:
			exit(0);
		default:
			printf("请重新输入\n");
		}
	}
}
int main(int argc, const char *argv[])
{
	int sfd;
	signal(2, handler);
	//网络初始化
	sfd = init_net();
	sockfd = sfd;
	do_picture(sfd);

	close(sfd);
	return 0;
}







