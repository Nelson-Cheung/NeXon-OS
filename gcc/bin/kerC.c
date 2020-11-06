#define maxProgCount 4
__asm__(".code16gcc");
//------------------------------------------------
//external functions
extern void LoadProgram(int head, int cylinder,
                        int sector, int sectorCount,
						int seg, int offset);
extern void lock1();
extern void unlock();
extern void ReadCommand();

//----------------------------------------------------
//definations
typedef struct 
{
	int ax;
	int bx;
	int cx;
	int dx;
	int si;
	int di;
	int bp;
	int es;
	int ds;
	int ss;
	int sp;
	int ip;
	int cs;
	int flags;
	int ID;
	int status;
	char name;
}PCB;

void InitProgInfo();
void MainProc();
void CreateProcess(int entryIP, int entryCS, int name);
void ProcCmd();
void ProcRun(int progCount);
void ProcKill(int progCount);
void Schedule();
//----------------------------------------------------
unsigned progSize[maxProgCount];
unsigned progSeg[maxProgCount];
unsigned progOffset[maxProgCount];
PCB pcbs[5];
int processCount;
PCB *CurrentProc;
int isAlive[maxProgCount];
char CMDline[30]="aaaaaaaaaaaaaaaaaaaa";


char header[] = "seq   name   size   segment    offset";


void InitProgInfo() //初始化
{
    unsigned i = 0;

    for(i = 0; i < maxProgCount; i++)
    {
        progSize[i] = 1024;
        progSeg[i] = 0x1000 * (i + 1);
        progOffset[i] = 0x200;
    }
}

void MainProc()
{
  
    InitProgInfo();
    while(1)
    {
        ProcCmd();
    }
}



void CreateProcess(int entryIP, int entryCS, int name)//创建进程
{
    int pcbID = 0;
    while(pcbID < maxProgCount)
    {
        if(pcbs[pcbID].status == 0)
            break;   //说明这个id没有被使用过，可以用，跳转到下面
        pcbID++;
    }

    if(pcbID == maxProgCount)
        return;

    processCount++;
    pcbs[pcbID].ip = entryIP;
    pcbs[pcbID].cs = entryCS;
    pcbs[pcbID].status = 1;
    pcbs[pcbID].ID = pcbID;
    pcbs[pcbID].name = name;

    //QueuePush(pcbID);
}

void ProcCmd()
{
	int i=0;
	lock1(); //恢复原来时钟中断向量
	CurrentProc=pcbs+4;
	ReadCommand();
	for(;i<4;i++) pcbs[i].status=0;
	int num=0;
        if(CMDline[num]>='1'&&CMDline[num]<='4')
        {
		while(CMDline[num]>='1'&&CMDline[num]<='4')
		{
        		if(CMDline[num]=='1')
        		ProcRun(0);
        		else if(CMDline[num]=='2')
        		ProcRun(1);
        		else if(CMDline[num]=='3')
        		ProcRun(2);
				else if(CMDline[num]=='4')
        		ProcRun(3);
			num++;
		}
		unlock(); //修改时钟中断使其指向timer函数
		
		num=0;
		for(int jj=0;jj<30;jj++)
		CMDline[jj]='a';
        }
}

void ProcRun(int progCount)
{
    int seg = (progCount + 1) * 0x1000;//段地址
    if(isAlive[progCount]) //如果该进程的isAlive不为0，说明已经在运行了
        return;
    isAlive[progCount] = 1;//表明该进程存活

    if(progCount == 0)
    {
        LoadProgram(0, 1, 1, 2, seg, 0x200);   //这里是调用汇编的loadprogram
        CreateProcess(0x200, seg, progCount);  //0x200->IP seg->CS 
    }
    else if(progCount == 1)
    {
        LoadProgram(0, 1, 3, 2, seg, 0x200);
        CreateProcess(0x200, seg, progCount);
    }
    else if(progCount == 2)
    {
        LoadProgram(0, 1, 5, 2, seg, 0x200);
        CreateProcess(0x200, seg, progCount);
    }
    else if(progCount == 3)
    {
        LoadProgram(0, 1, 7, 2, seg, 0x200);
        CreateProcess(0x200, seg, progCount);
    }
}

void ProcKill(int progCount)
{
    
    isAlive[progCount] = 0;
    if(progCount > 0&&progCount < maxProgCount)
	{
         if(pcbs[progCount].status)
            processCount--;
        pcbs[progCount].status = 0;       //将进程状态置为0；
	}
}

void Schedule()
{
	int i,j=0;
	if(CurrentProc==pcbs) i=0;
	else if(CurrentProc==pcbs+1) i=1;
	else if(CurrentProc==pcbs+2) i=2;
	else if(CurrentProc==pcbs+3) i=3;
	else i=3;
	for(;j<4;j++) //循环4次；
	{
		if(i==3) 
		{
			CurrentProc=pcbs;
			i=0;
		}
		else 
		{
			CurrentProc++;
			i++;
		}
		if(CurrentProc->status!=0)
			return;
	}
	CurrentProc=pcbs+4;
	return;
}
