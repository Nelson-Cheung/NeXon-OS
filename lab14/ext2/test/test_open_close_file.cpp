    bool ans;
    DirectoryEntry rootDir, current;

    rootDir.inode = 0;
    rootDir.type = DIRECTORY_FILE;
    rootDir.setName("/");

    printFileSystem(0, rootDir);

    dword h1, h2, h3, h4;
    h1 = sysFileSystem.openFile("/second dir/second dir/second file", READ, REGULAR_FILE);
    h2 = sysFileSystem.openFile("/second dir/second dir/second file", READ, REGULAR_FILE);
    h3 = sysFileSystem.openFile("/second dir/second dir/second file", WRITE, REGULAR_FILE);
    h4 = sysFileSystem.openFile("/second dir/second dir/second file", READ | WRITE, REGULAR_FILE);
    printf("%d %d %d %d\n", h1, h2, h3, h4);

    sysFileSystem.closeFile(h1);
    sysFileSystem.closeFile(h2);
    h1 = sysFileSystem.openFile("/second dir/second dir/second file", WRITE, REGULAR_FILE);
    h2 = sysFileSystem.openFile("/second dir/second dir/second file", READ, REGULAR_FILE);
    h3 = sysFileSystem.openFile("/second dir/second dir/second file", READ, REGULAR_FILE);
    h4 = sysFileSystem.openFile("/second dir/second dir/second file", READ | WRITE, REGULAR_FILE);
    printf("%d %d %d %d\n", h1, h2, h3, h4);

    sysFileSystem.closeFile(h1);
    h1 = sysFileSystem.openFile("/second dir/second dir/second file", WRITE | READ, REGULAR_FILE);
    h2 = sysFileSystem.openFile("/second dir/second dir/second file", READ, REGULAR_FILE);
    h3 = sysFileSystem.openFile("/second dir/second dir/second file", READ, REGULAR_FILE);
    h4 = sysFileSystem.openFile("/second dir/second dir/second file", WRITE, REGULAR_FILE);
    printf("%d %d %d %d\n", h1, h2, h3, h4);