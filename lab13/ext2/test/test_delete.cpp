    sysFileSystem.deleteFile("/second file", REGULAR_FILE);
    // printFileSystem(0, rootDir);

    sysFileSystem.deleteFile("/second dir/second file", REGULAR_FILE);
    // printFileSystem(0, rootDir);

    sysFileSystem.deleteFile("/second dir/second dir", DIRECTORY_FILE);
    //printFileSystem(0, rootDir);

    sysFileSystem.deleteFile("/second dir", DIRECTORY_FILE);
    // printFileSystem(0, rootDir);

    sysFileSystem.deleteFile("/", DIRECTORY_FILE);
    // printFileSystem(0, rootDir);

    dword ans = sysFileSystem.deleteFile("/second dir", DIRECTORY_FILE);
    // printf("%d\n", ans);
    // printFileSystem(0, rootDir);

    sysFileSystem.deleteFile("/first file", REGULAR_FILE);
    sysFileSystem.deleteFile("/first dir", DIRECTORY_FILE);

    sysFileSystem.deleteFile("/.", DIRECTORY_FILE);
    sysFileSystem.deleteFile("/..", DIRECTORY_FILE);
    sysFileSystem.deleteFile("/fir file", REGULAR_FILE);
    printFileSystem(0, rootDir);

    sysFileSystem.createFile("/third file", REGULAR_FILE);
    sysFileSystem.createFile("/third dir", DIRECTORY_FILE);
    sysFileSystem.createFile("/third dir/third file", REGULAR_FILE);
    printFileSystem(0, rootDir);