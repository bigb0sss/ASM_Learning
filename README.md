# b0ssTheASM 😎

## x86 (32-bit)

### Compiling ASM in x86
```
$ nasm -f elf32 -o <file>.o <file>.asm
$ ld -o <file> <file>.o
```
### Finding Syscalls
```
$ cat /usr/include/i386-linux-gnu/asm/unistd_32.h 
```
