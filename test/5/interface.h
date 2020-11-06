#include "mystring.h"
#define OffsetOfUserPrg 0x100
#define SegOfUserPrg 0x1000
#define newline putchar('\r');putchar('\n')

enum Date
{
    Second=0, Minute=2, Hour=4, Day=7, Month=8, Year=9
};
extern uint8_t getDateInfo(enum Date func);



int SizeofSector = 512;
char *ComlistTitle = "pid name cylinder head sector len  addr  seg";
struct sector
{
    int pid;
    char name[20];
    int cylinder;
    int head;
    int sector;
    int len;
    int addr;
    int seg;
};

const struct sector Comlist[] = {
//  pid   name   柱面号  磁头号 起始扇区号 扇区数 内存的偏移地址
{    1, "LU.com",  0,      1,      1,      2, OffsetOfUserPrg, SegOfUserPrg},
{    2, "LD.com",  0,      1,      3,      2, OffsetOfUserPrg, SegOfUserPrg},
{    3, "RU.com",  0,      1,      5,      2, OffsetOfUserPrg, SegOfUserPrg},
{    4, "RD.com",  0,      1,      7,      2, OffsetOfUserPrg, SegOfUserPrg},
{    5, "test.com",0,      1,      9,      6, OffsetOfUserPrg, SegOfUserPrg}
};

void readbuff(char *buff, int maxLength)
{
	if (!buff)
		return;
	int len = 0;
    while(1) {
        char c = getch();
        if(!(c==0xD || c=='\b' ||c==3|| c>=32 && c<=127)) { continue; }  
        if(c==0x0D){
            break;
        }
        else if(c==3){
            len = 0;
            break;
        }
        if(len > 0 && len < maxLength-1) { 
			if(c == '\b') {  
                putchar('\b');
                putchar(' ');
                putchar('\b');
                --len;
            }
            else{
                putchar(c);  
                buff[len] = c;
                ++len;
            }
        }
        else if(len >= maxLength-1) {  
            if(c == '\b') {  
                putchar('\b');
                putchar(' ');
                putchar('\b');
                --len;
            }
        }
        else{  
			if(c != '\b') {
                putchar(c);  
                buff[len] = c;
                ++len;
            }
        }
    }
    putchar('\r'); putchar('\n');
    buff[len] = '\0';  
}

//calculate position of Col
int middleCol(int len){
    int colMax = 80;
    return (colMax - len) / 2;
}

//print string to middle of the screen
void printMiddle(char*str, int row){
    int len = strlen(str);
    int col = middleCol(len);
    printPos(str, len, row, col);
}

void Greet()
{
    cls();
    char* title = "17338233 OS";
    char* hint = "Press Enter to go on";
    char* author = "ZhengGeHan 17338233";
    char* date = "2020.5.13";
    printMiddle(title, 10);
    printMiddle(author, 12);
    printMiddle(date, 14);
    printMiddle(hint, 20);
}
void prompt(){
    char *str = "->";
    print(str);
}
void printInfo(){
    char *str = 
    "List of commands:\n\r"
    "\r\n"
    "    help -- Show information about builtin commands\r\n"
    "    cls -- Clear the terminal screen\r\n"
    "    ls -- Show a list of user programmes' information\r\n"
    "    run <arg> -- Run user programmes in sequence,\r\n"
    "        spaces between pid is prohibited. e.g. `run 134`\r\n"
    "    shutdown -- Force shutdown the machine\r\n"
    "    ctrl-c -- interrput current input\r\n"
    ;
    print(str);
}

void printDetail(struct sector Com){
    putnum(Com.pid,10);
    printchar(' ',2);
    print(Com.name);
    printchar(' ',3);
    putnum(Com.cylinder,10);
    printchar(' ',6);
    putnum(Com.head,10);
    printchar(' ',5);
    putnum(Com.sector,10);
    printchar(' ',4);
    putnum(Com.len*SizeofSector,10);
    putchar(' ');
    putnum(Com.addr,16);
    printchar(' ',2);
    putnum(Com.seg,16);
}

void printDate(){
    int year=getDateInfo(Year),
    month=getDateInfo(Month),
    day=getDateInfo(Day),
    hour=getDateInfo(Hour),
    minute=getDateInfo(Minute),
    second=getDateInfo(Second);

    char TimeBuffer[22]={0};
    char *yearPrefix = "20";
    strcat(TimeBuffer, yearPrefix);
    strcat(TimeBuffer, itoa(bcd2dec(year), 10));
    strAppend(TimeBuffer, '-');
    if(month<10){
        strAppend(TimeBuffer, '0');
    }
    strcat(TimeBuffer, itoa(bcd2dec(month), 10));
    strAppend(TimeBuffer, '-');
    if(day<10){
        strAppend(TimeBuffer, '0');
    }
    strcat(TimeBuffer, itoa(bcd2dec(day), 10));
    strAppend(TimeBuffer, ' ');
    if(hour<10){
        strAppend(TimeBuffer, '0');
    }
    strcat(TimeBuffer, itoa(bcd2dec(hour), 10));
    strAppend(TimeBuffer, ':');
    if(minute<10){
        strAppend(TimeBuffer, '0');
    }
    strcat(TimeBuffer, itoa(bcd2dec(minute), 10));
    strAppend(TimeBuffer, ':');
    if(second<10){
        strAppend(TimeBuffer, '0');
    }
    strcat(TimeBuffer, itoa(bcd2dec(second), 10));

    printPos(TimeBuffer,20,24,58);
}


void sysc_int22(){
    char str[] = "INT22H is here!";
    printPos(str,strlen(str),22,50);
}