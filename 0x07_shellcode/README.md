# Shellcode

## Shellcoding Process

# 1) Create an exit.nasm
```asm
; Simple Exit Program

global _start			

section .text
_start:

    	mov eax, 1
	mov ebx, 10
	int 0x80
```
# 2) Compile the exit.nasm
```asm
$ nasm -f elf32 -o exit exit.nasm
$ ld -o exit exit.o
```
# 3) objdump the exit program
```asm
$ objdump -d exit -M intel		; -M intel: Intel format

exit:     file format elf32-i386

Disassembly of section .text:

08048060 <_start>:
 8048060:	b8 01 00 00 00       	mov    eax,0x1
 8048065:	bb 0a 00 00 00       	mov    ebx,0xa
 804806a:	cd 80                	int    0x80
```
# 4) Copy and Paste the opcode to the skeleton C program
