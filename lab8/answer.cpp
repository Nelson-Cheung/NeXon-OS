void _shell(void *arg)
{
    
    _enable_interrupt();
    Clear();
    MoveCursor(80);


    money = 1000;
    saveAndTake.initialize(1);
    createThread(&_thread1, nullptr, 3);
    createThread(&_thread2, nullptr, 1);

    while (1)
    {

    }
}

void _thread1(void *arg)
{
    int save = 0;
    PCB *cur = (PCB *)_running_thread();

    while (1)
    {
        saveAndTake.P();
        money += 10;
        save += 10;
        printf("----------Father----------\n"
                "money: %d, total save: %d\n"
                "-------------------------\n", 
                money, save);
        wait(0x5fffff);
        saveAndTake.V();
    }
}

void _thread2(void *arg)
{
    int take = 0;

    while (1)
    {
        saveAndTake.P();
        money -= 20;
        take += 20;
        printf("------------son-----------\n"
                "money: %d, total take: %d\n"
                "-------------------------\n", 
                money, take);
        wait(0x5fffff);
        saveAndTake.V();
    }
}

//////////////////////////////////////////////////////////////////////

void _shell(void *arg)
{
    
    _enable_interrupt();
    Clear();
    MoveCursor(80);

    fruit = bless = 0;
    fruit_empty.initialize(10);
    fruit_full.initialize(0);
    bless_empty.initialize(5);
    bless_full.initialize(0);
    mutex.initialize(1);

    createThread(&_thread1, nullptr, 1);
    createThread(&_thread2, nullptr, 1);
    createThread(&_thread3, nullptr, 1);

    while (1)
    {

    }
}

void _thread1(void *arg)
{
    while (1)
    {
        fruit_full.P();
        bless_full.P();
        mutex.P();
        --fruit;
        --bless;
        printf("Father: get bless and fruit, fruit left: %d, bless left: %d\n", fruit, bless);
        mutex.V();
        wait(0x2fffff);
        fruit_empty.V();
        bless_empty.V();        
    }
}

void _thread2(void *arg)
{
    while (1)
    {
        fruit_empty.P();
        mutex.P();
        ++fruit;
        printf("son one: put fruit, fruit left: %d\n", fruit);
        mutex.V();
        wait(0x5fffff);
        fruit_full.V();
    }
}

void _thread3(void *arg)
{
    while(1) {
        bless_empty.P();
        mutex.P();
        ++bless;
        printf("son two: give blessing, bless left: %d\n", bless);
        mutex.V();
        wait(0x8fffff);
        bless_full.V();
    }
}

//////////////////////////////////////////////////////////////
void _shell(void *arg)
{

    _enable_interrupt();
    Clear();
    MoveCursor(80);

    mutex.initialize(1);
    w.initialize(1);
    rw.initialize(1);
    counter = 0;

    for (int i = 0; i < 2; ++i)
    {
        createThread(&writer, nullptr, i+1);
    }

    for (int i = 0; i < 3; ++i)
    {
        createThread(&reader, nullptr, i+1);
    }

    while (1)
    {
    }
}

void writer(void *arg)
{
    PCB *cur = (PCB *)_running_thread();
    while (1)
    {
        w.P();
        rw.P();
        printf("writer: %d, write start\n", cur->pid);
        wait(0xffffff);
        printf("writer: %d, write complete\n", cur->pid);
        rw.V();
        w.V();
    }
}

void reader(void *arg)
{
    PCB *cur = (PCB *)_running_thread();
    while (1)
    {
        w.P();
        mutex.P();
        if (counter == 0)
        {
            rw.P();
        }
        ++counter;
        mutex.V();
        w.V();

        printf("reader: %d, read start\n", cur->pid);
        wait(0x5fffff);
        printf("reader: %d, read complete\n", cur->pid);

        mutex.P();
        --counter;
        if (counter == 0)
        {
            rw.V();
        }
        mutex.V();
    }
}