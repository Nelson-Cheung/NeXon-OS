dword openFile(const char *path, dword type, bool rw);
dword deleteFile(const char *path, dword type);
dword createFile(const char *path, dword type);
dword clearFile(dword handle);
dword readFile(dword handle, dword start, void *buffer, dword size);
dword writeFile(dword handle, dword start, void *buffer, dword size);
dword closeFile(dword handle);
dword getFileSize(dword handle);