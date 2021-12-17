#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void fun(int *);
int main(int argc, const char *argv[])
{
/*	char p1[3] = {'d','e','f'};
	char p[3];
	p[1] = 'a';
	printf("%d\n",strlen(p));
	printf("%d\n",strlen(p1));

	printf("%s\n",p);
	printf("%s\n",p1);
	unsigned int count = getno();
 	int i;
	char **buf = (char **)malloc(sizeof(char)*count);
	char *p = NULL;
	for(i=0;i<count;i++)
	{
		p = (char*) malloc(100);
		buf[i] = p;
	}
	buf[0] = "hello";
	buf[1] = "world";
	printf("%s%s\n",buf[0],buf[1])
	int a[10] = {1,2,3,4,5,6,7,8,9,0};
	int *p = "hello";
	printf("%x\n",p);
	printf("%x\n",p+1);
	printf("%p\n",p);
	printf("%p\n",p+1);
	printf("%p\n",&p);
	printf("%p\n",&p+1);
*/
	char m =15;
	//int *p = &m;
	//*p = 20;
	fun(&m);
	printf("%x\n",m);
	free(&m+1);
	free(&m+2);
	free(&m+3);
	return 0;
}
void fun(int * p)
{
	*p = 0x12345678;
}

