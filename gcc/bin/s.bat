set name=%~n1
gcc  -masm=intel  -Og -S  %name%.c -o %name%.S1
gcc -masm=intel -m16  -Og -S %name%.c -o %name%.S2

