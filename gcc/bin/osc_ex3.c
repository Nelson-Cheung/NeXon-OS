
__asm__(".code16gcc\n");
char myMessage[11]="XxAaBbCcDd";
void myUpper(){
    for(int i=0;i<11;i++){
        if(myMessage[i]>='a'&&myMessage[i]<='z')
            myMessage[i]=myMessage[i]+'A'-'a';
    }
}