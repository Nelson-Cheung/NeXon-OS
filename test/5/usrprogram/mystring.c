/*程序源代码（upper.c）*/
#include "mystring.h"
extern void cls();
extern void shutdown();
extern void syscall_putchar(const char c);
extern void printPos(const char *str, int n, uint8_t row, uint8_t col);
extern char syscall_getch();
int strlen(const char *str)
{
	int cnt = 0;
	while (str[cnt++])
		;
	return cnt - 1;
}

void print(const char *str)
{
	for (int i = 0, length = strlen(str); i < length; i++)
	{
		syscall_putchar(str[i]);
	}
}


void printchar(const char c,int n){
    for (int i = 0; i < n; i++)
    {
        syscall_putchar(c);
    }
    
}

char* itoa(int num, int base) {
	static char buf[32] = {0};
	if(num==0) return "0";
	int i = 30;
	for(; num && i ; --i, num /= base) {
		buf[i] = "0123456789ABCDEF"[num % base];
    }
	return &buf[i+1];
}

void putnum(const int num,int base){
    print(itoa(num,base));
}

int isnum(const char c){
	    return c>='0' && c<='9';
}

int checknum(const char* str,int max){
	int isNum=1;
	for (int i = 0, length = strlen(str); i < length; i++)
	{
		if(!isnum(str[i])){
			isNum = 0;
			break;
		}
		else
		{
			if(str[i]-'0' > max){
				isNum = 0;
				break;
			}
		}
		
	}
	return isNum;
}

int find(const char *buff, int len, char c){
	if (buff[len] != '\0')
		return 0;
	int i = 0;
	while (i < len && buff[i++] != c)
		;
	return i - 1;
}

void split(const char*buff,char*dest1,char*dest2){
	dest2[0] = '\0';
	int len = strlen(buff);
	int n = find(buff, len, ' ');
	if(n==len-1)
		n = len;
	int i;
	for (i = 0; i < n; i++)
	{
		dest1[i] = buff[i];
	}
	dest1[i] = '\0';
	while (buff[i]&&buff[i]==' ')
	{
		i++;
	}
	int j = 0;
	while(buff[i]){
		dest2[j++] = buff[i++];
	}
	dest2[j] = '\0';
}

int strcmp(const char *lhs,const char *rhs)
{
	int i = 0;
	while (1)
	{
		if (lhs[i] == '\0' || rhs[i] == '\0')
			break;
		if (lhs[i] != rhs[i])
			break;
		++i;
	}
	return lhs[i] - rhs[i];
}
char *strcat(char *dest, const char *src)
{
    char *tmp = dest;

    while (*dest)
        dest++;
    while ((*dest++ = *src++) != '\0');
    return tmp;
}
void strAppend(char*str,const char c){
	int len = strlen(str);
	str[len] = c;
	str[len + 1] = '\0';
}
uint8_t bcd2dec(const uint8_t bcd)
{
    return ((bcd & 0xF0) >> 4) * 10 + (bcd & 0x0F);
}
