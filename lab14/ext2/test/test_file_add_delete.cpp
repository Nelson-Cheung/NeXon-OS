    sysFileSystem.createFile("/NeXon", REGULAR_FILE);
    dword handle = sysFileSystem.openFile("/NeXon", true, REGULAR_FILE);
    if (handle == -1)
    {
        while (1)
        {
        }
    }

    printFileSystem(0, rootDir);

    sysFileSystem.appendFileBlock(handle);
    sysFileSystem.writeFileBlock(handle, 0,
                                 (void *)"Welcome to NeXon world!\n"
                                         "Author: Nelson Cheung\n"
                                         "Enjoy your trip\n");
    byte buffer[SECTOR_SIZE + 1];
    sysFileSystem.readFileBlock(handle, 0, buffer);
    printf("file content\n%s\n", buffer);

    sysFileSystem.popFileBlock(handle);

    sysFileSystem.appendFileBlock(handle);
    sysFileSystem.appendFileBlock(handle);

    for (int i = 0; i < SECTOR_SIZE; ++i)
    {
        buffer[i] = 'a';
    }

    buffer[SECTOR_SIZE] = '\0';

    sysFileSystem.writeFileBlock(handle, 0, buffer);

    for (int i = 0; i < SECTOR_SIZE; ++i)
    {
        buffer[i] = 'b';
    }

    buffer[SECTOR_SIZE] = '\0';
    sysFileSystem.writeFileBlock(handle, 1, buffer);

    sysFileSystem.readFileBlock(handle, 0, buffer);
    printf("file content\n%s\n", buffer);
    sysFileSystem.readFileBlock(handle, 1, buffer);
    printf("file content\n%s\n", buffer);