#include "interface.h"
#include "process.h"
#define MAX_BUFLEN 30 
extern void loadUsrProgram(int seg, int addr, int len, int head, int cylinder, int sector);

void shell(){
    int usrprogNum=sizeof(Comlist) / sizeof(struct sector);
    enum commandEnum{  Help,Cls,Shutdown,Run,List};
    char userbuff[MAX_BUFLEN]={0};
    char command[MAX_BUFLEN]={0};
    char target[MAX_BUFLEN]={0};
    char *emptystr = "\0";
    char *commands[] = {"help","cls","shutdown","run","ls"};
    cls();
    printInfo();
    while (1)
    {
        prompt();
        readbuff(userbuff, MAX_BUFLEN);
        if(strcmp(userbuff,emptystr)==0){
            continue;
        }
        if(strcmp(userbuff, commands[Shutdown]) == 0) {
            shutdown();
        }
        else if(strcmp(userbuff, commands[Cls]) == 0) {
            cls();
        }
        else if(strcmp(userbuff, commands[Help]) == 0) {
            printInfo();
        }
        else if(strcmp(userbuff, commands[List]) == 0) {
            print(ComlistTitle);
            newline;
            for (int i = 0; i < usrprogNum; i++)
            {
                printDetail(Comlist[i]);
                newline;
            }
        }
        else {
            int valid=0;
            split(userbuff, command, target);
            if(strcmp(command, commands[Run]) == 0) {
                valid =target[0]!='\0'&& checknum(target,usrprogNum);
            }
            if(valid){
                for (int i = 0, len = strlen(target); i < len; i++)
                {
                    int pid = target[i] - '0'-1;
                    loadUsrProgram(Comlist[pid].seg,Comlist[pid].addr, Comlist[pid].len, Comlist[pid].head, Comlist[pid].cylinder, Comlist[pid].sector);
                    cls();
                }
            }
            else{
                char *error_msg = "Bad command.Please try other.Key in \"help\" for help\r\n";
                print(error_msg);
            }
            
        }
    }
    
}

