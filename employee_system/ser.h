#ifndef __SER__H__                                               
#define __SER__H__

#define N 500
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
    char address[128];  //地址、密码
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

char sql[N] = {0};
int init_net(void);
void *rcv_cli_msg(void *arg);
int create_mydatebase(void);
int do_register(int);

int employee_load(int);
int employee_add(int);
int employee_modif(int);
int employee_search(int);
int do_back(int);

int admin_load(int);
int admin_add(int);
int admin_del(int);
int admin_modif(int);
int admin_search(int);
int admin_back(int);

#endif

