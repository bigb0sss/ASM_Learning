; Executable name : execve_04_sh_stack
; Version         : 1.0
; Created date    : 07/02/2020
; Last update     : 07/02/2020
; Author          : bigb0ss
; Description     : 1) This is to run "/bin/sh" using execve function
;                   2) This will leverage stack to hardcode "/bin/sh" with shellcode. 
;                   3) Once .nasm created --> Compile it
;                   4) Extract the shellcode using objdump
;                   5) Update the skeleton.c with the shellcode --> Compile it
;                   6) Run the program to see if we can successfully load "/bin/sh"
;
;                  
; ================================ Execve Layout ================================
; int execve(const char *filename, char *const argv[], char *const envp[]);
;            -------- EBX -------- ------- ECX ------- ------- EDX --------
;                      ⬇                                       ⬇
;               "/bin/bash, 0x0"            ⬇            "0x00000000"
;                              "Addr of /bin/sh, 0x00000000"
; ===============================================================================
;

global _start

section .text

_start:

	xor eax, eax			; Preparing Nulls in EAX register
	push eax			; Pushing the first Null DWORD
	
	; //bin/sh (8 bytes) - "/" does not affect when running "/bin/sh" while being interpretated
	;
	; [Reverse order of //bin/sh]
	; String length : 8
	; hs/n : 68732f6e
	; ib// : 69622f2f

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
