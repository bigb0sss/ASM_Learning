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

        jmp short call_shellcode
        

shellcode:
        
        pop esi
        
        ; Preparing for values to utilize for further execve layout usage
        xor ebx, ebx
        mov byte [esi +9], bl
        mov dword [esi +10], esi
        mov dword [esi +14], ebx


        ; Placing each value for execve usage
        lea ebx, [esi]
        lea ecx, [esi +10]
        lea edx, [esi +14]
        
      	; exit() syscall
	xor eax, eax		              ; Set EAX to zero
  	mov al, 0x1	                      ; Adding "1" to AL (= lower byte of EAX)
  	xor ebx, ebx	                      ; Set EBX to zero
  	mov bl, 0xa		              ; Adding "10" to BL (= lower byte of EBX)
	int 0x80
        
        
        
        
        
        
        
