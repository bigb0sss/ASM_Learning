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
```bash
$ cat /usr/include/i386-linux-gnu/asm/unistd_32.h 
```
<br />

## GDB
### Finding Entry Points
```bash
(gdb) shell readelf -h <file>
```
### Debugging Commands
```bash
(gdb) info proc mappings        ; Show memory space
(gdb) info functions            ; Show available functions
(gdb) info variables            ; Show available variables
```
### Hooking
```bash
(gdb) define hook-stop          ; Setting the hooks
> print/x $eax                  ; Prints the current EAX register in hex
> print/x $ebx                  ; Prints the current EBX register in hex
> print/x $ecx                  ; Prints the current ECX register in hex
> print/x $edx                  ; Prints the current EDX register in hex
> x/8xb &data                   ; Examine next 8 values at data segments in hex
> disassemble $eip,+5           ; Disassemble next 5 values from the current EIP register
> end

* Display (Show the following outpus w/o hooking)
(gdb) display/x $eax
(gdb) display/x $ebx
(gdb) display/x $ecx
```

## References/Resources
* Intel IA-32 Manuel - (Intel® 64 and IA-32 ArchitecturesSoftware Developer’s Manual)[https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-instruction-set-reference-manual-325383.pdf]
