set name=%~n1
objdump -Mintel,i386 -S %name%.o > %name%.a