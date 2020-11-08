    bool ans;
    DirectoryEntry rootDir, current;

    rootDir.inode = 0;
    rootDir.type = DIRECTORY_FILE;

    ans = sysFileSystem.createEntryInDirectory(rootDir, "first file", REGULAR_FILE);
    printf("create file in /, result: %d\n", ans);

    printFileSystem(0, rootDir);

    ans = sysFileSystem.createEntryInDirectory(rootDir, "first dir", DIRECTORY_FILE);
    printf("create directory in /, result: %d\n", ans);

    printFileSystem(0, rootDir);

    current = sysFileSystem.getEntryInDirectory(rootDir, "first dir", DIRECTORY_FILE);
    //printf("inode: %d, name: %s, type: %d\n", current.inode, current.name, current.type);

    if (current.inode != -1)
    {
        ans = sysFileSystem.createEntryInDirectory(current, "first file", REGULAR_FILE);
        printf("create file in /first dir/, result: %d\n", ans);
        printFileSystem(0, rootDir);

        ans = sysFileSystem.createEntryInDirectory(current, "first dir", DIRECTORY_FILE);
        printf("create directory in /first dir/, result: %d\n", ans);
        printFileSystem(0, rootDir);
    }
    while (1)
    {
    }