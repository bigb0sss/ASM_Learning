<p align="center">
  <img src="https://github.com/bigb0sss/b0ssTheASM/blob/master/asm.png">
</p>

## x86 (32-bit)

### Compiling ASM in x86
```bash
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
### Hooking
```
(gdb) define hook-stop
> print/x $eax
> print/x $ebx
> print/x $ecx
> print/x $edx
> x/8xb &data
> disassemble $eip,+5
> end

* Display (Show the following outpus w/o hooking)
(gdb) display/x $eax
(gdb) display/x $ebx
(gdb) display/x $ecx
```
