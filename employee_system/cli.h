#ifndef __CLI__H__
#define __CLI__H__

#define PORT 1024
#define IP "192.168.1.188"
#define ERR_MSG(msg) do{\
	printf("%s:%s:%d\n",__FILE__,__func__,__LINE__);\
	perror(msg);\
}while(0)

struct employee{
	char name[20];
	char sex[1];
	int age;
	char address[128];	//地址、密码
	float salary;
	char wkno[20];
	char phone[128];	
}emp_buf;

struct message{
    char type;
    char account_name[20];            
    char name[20];
    char passwd[20];
}mes_buf;

int init_net(void);
int sign_in(int);
int do_load(int);

int employee_load(int);
int do_add(int);
int do_modi_info(int);
int do_search_info(int);
int do_back(int);

int admin_load(int);
int do_add_admin(int);
int do_del_info_admin(int);
int do_modi_info_admin(int);
int do_search_info_admin(int);
int do_back_admin(int);
#endif

