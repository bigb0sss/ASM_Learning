# Shellcode

## Shellcoding Process

### 1) Create an exit.nasm
```asm
; Simple Exit Program

global _start			

section .text
_start:

    	mov eax, 1
	mov ebx, 10
	int 0x80
```
### 2) Compile the exit.nasm
```bash
$ nasm -f elf32 -o exit exit.nasm
$ ld -o exit exit.o
```
### 3) objdump the exit program
```bash
$ objdump -d exit -M intel		; -M intel: Intel format

exit:     file format elf32-i386

Disassembly of section .text:

08048060 <_start>:
 8048060:	b8 01 00 00 00       	mov    eax,0x1
 8048065:	bb 0a 00 00 00       	mov    ebx,0xa
 804806a:	cd 80                	int    0x80
```
### 4) Copy and Paste the opcode to the skeleton C program
```c
#include<stdio.h>
#include<string.h>

unsigned char shellcode[] = 
"\xb8\x01\x00\x00\x00\xbb\x0a\x00\x00\x00\xcd\x80";

main() {
        printf("[+] Shellcode Length: %d\n", strlen(shellcode));
        int (*ret)() = (int(*)())shellcode;
        ret();        

}
```
--> But the above shellcode wouldn't be useful since it contains too many null bytes

### 5) Null byte avoidance
```asm
; Simple Exit Program (Adding XOR to avoid null bytes)

global _start			

section .text
_start:

	xor eax, eax		; Set EAX to zero
	mov al, 0x1		; Adding "1" to AL (= lower byte of EAX)
	xor ebx, ebx		; Set EBX to zero
	mov bl, 0xa		; Adding "10" to BL (= lower byte of EBX)
	int 0x80
```

### 6) Extracting shellcode from the compiled file
```bash
# This will only outputs the shellcode with copy and paste friendly format
# https://www.commandlinefu.com/commands/view/6051/get-all-shellcode-on-binary-file-from-objdump

$ objdump -d ./PROGRAM | grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'
```

### 7) Put the extracted shellcode into the skelton.c & Compile it
```bash
$ gcc -fno-stack-protector -z execstack exit.c -o exit
```
<br />

## Making Strings in Reverse Order
```python
$ python
>>> code = 'Hello World\n'
>>> code[::-1]
>>> code[::-1].encode('hex')
```
