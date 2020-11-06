#include "cstdio.h"

int main()
{
   	char ch,str[80];
   	int a;
   	ch = getchar();
   	scanf("%s", str);
   	scanf("%d",&a);
  	putchar(ch);
  	printf("%s", str);
   	printf("ch=%c, a=%d, str=%s\n", ch, a, str);
    return 0;
}
