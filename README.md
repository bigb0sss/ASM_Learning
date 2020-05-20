# b0ssTheASM

## ⚔️86 (32-bit)

### Compiling ASM in x86
```
$ nasm -f elf32 -o <file>.o <file>.asm
$ ld -o <file> <file>.o
```
### Finding Syscalls
```
$ cat /usr/include/i386-linux-gnu/asm/unistd_32.h 
```
<br />

## GDB
### Finding Entry Points
```
(gdb) shell readelf -h <file>
```
### Debugging Commands
```
(gdb) info proc mappings        ; Show memory space
(gdb) info functions            ; Show available functions
(gdb) info variables            ; Show available variables
```
