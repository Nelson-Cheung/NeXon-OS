#include <iostream>
using namespace std;

int main()
{

	float a,x,y;
	for(y=1.5f; y>-1.5f; y-=0.1f)
	{
		for(x=-1.5f; x<1.5f; x+=0.05f)
		{
			a = x*x+y*y-1;
			//这里的@符号即为打印出的心形图案符号，可更改
			char ch = a*a*a-x*x*y*y*y<=0.0f?'@':' '; 
			putchar(ch);  
			//或者putchar(a*a*a-x*x*y*y*y<=0.0f?'*':' ');
		}
		printf("\n");
    }
}
