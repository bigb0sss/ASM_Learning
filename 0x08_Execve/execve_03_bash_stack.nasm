; Executable name : execve_03_bash_stack
; Version         : 1.0
; Created date    : 07/02/2020
; Last update     : 07/02/2020
; Author          : bigb0ss
; Description     : 1) This is to run "/bin/bash" using execve function
;                   2) This will leverage stack to hardcode "/bin/bash" with shellcode. 
;                   3) Once .nasm created --> Compile it
;                   4) Extract the shellcode using objdump
;                   5) Update the skeleton.c with the shellcode --> Compile it
;                   6) Run the program to see if we can successfully load "/bin/bash"
;
;                  
; ================================ Execve Layout ================================
; int execve(const char *filename, char *const argv[], char *const envp[]);
;            -------- EBX -------- ------- ECX ------- ------- EDX --------
;                      ⬇                                       ⬇
;               "/bin/bash, 0x0"            ⬇            "0x00000000"
;                            "Addr of /bin/bash, 0x00000000"
; ===============================================================================
;

global _start

section .text

_start:

	xor eax, eax			; Preparing Nulls in EAX register
	push eax			; Pushing the first Null DWORD
	
	; ////bin/bash (12 bytes) - "/" does not affect when running "/bin/bash" while being interpretated
	;
	; [Reverse order of ////bin/bash]
	; String length : 12
	; hsab : 68736162
	; /nib : 2f6e6962
	; //// : 2f2f2f2f
	
	push 0x68736162
	push 0x2f6e6962
	push 0x2f2f2f2f
	
	mov ebx, esp
	push eax
	mov edx, esp
	push ebx
	mov ecx, esp
	
	; syscall()
	mov al, 0xb
	int 0x80

	
