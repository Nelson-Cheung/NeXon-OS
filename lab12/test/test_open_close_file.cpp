    // 模拟多线程
    dword h1, h2, h3, h4;

    h1 = sysFileSystem.openFile("/first file", true);
    h2 = sysFileSystem.openFile("/first file", false);
    printf("%d %d\n", h1, h2);

    sysFileSystem.closeFile(h1);
    sysFileSystem.closeFile(h2);

    h1 = sysFileSystem.openFile("/first file", false);
    h2 = sysFileSystem.openFile("/first file", true);
    printf("%d %d\n", h1, h2);

    sysFileSystem.closeFile(h1);
    sysFileSystem.closeFile(h2);

    h1 = sysFileSystem.openFile("/first file", true);
    h2 = sysFileSystem.openFile("/first file", true);
    printf("%d %d\n", h1, h2);

    h3 = sysFileSystem.openFile("/first dir/first file", true);
    h4 = sysFileSystem.openFile("/first dir/first dir/first file", true);

    printf("%d %d\n", h3, h4);

    sysFileSystem.closeFile(h3);
    h3 = sysFileSystem.openFile("/first dir/first file", false);

    printf("%d\n", h3);