; Executable name : shellcode_03_helloWorld
; Version         : 1.0
; Created date    : 05/31/2020
; Last update     : 05/31/2020
; Author          : bigb0ss
; Description.    : Print "Hello World!" using shellcode
;                   This will leverage a technique called JMP-CALL-POP. 
;                   When the Call intsturction is called, it saves the next value into the stack.
; 
;

global _start

section .text

_start:

	jmp short call_shellcode                ; Short JMP to "call_shellcode"


shellcode: 

	  ; write() syscall
    xor eax, eax                          ; Set EAX to zero
  	mov al, 0x4                           ; Adding "4" to AL (= lower byte of EAX)
  	xor ebx, ebx                          ; Set EBX to zero
  	mov bl, 0x1                           ; Adding "1" to AL (= lower byte of EBX)

	  pop ecx                               ; POP the ECX value which is "message"

  	xor edx, edx                          ; Set EDX to zero
  	mov dl, 13                            ; Adding "13" to AL (= lower byte of EDX)
	  int 0x80


    ; exit() syscall
	  xor eax, eax		                      ; Set EAX to zero
  	mov al, 0x1	                        	; Adding "1" to AL (= lower byte of EAX)
  	xor ebx, ebx	                      	; Set EBX to zero
  	mov bl, 0xa		                        ; Adding "10" to BL (= lower byte of EBX)
	  int 0x80

call_shellcode:

	  call shellcode                        ; Calling "shellcode"
  	message: db "Hello World!", 0xA       ; When call gets called, it puts this "message' onto the next POP register
   
