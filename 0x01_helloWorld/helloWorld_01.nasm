; Executable name : helloWorld_01
; Version         : 1.0
; Created date    : 05/20/2020
; Last update     : 05/20/2020
; Author          : bigb0ss
; Description.    : Print "Hello World!"
;
;

; Global Entry Point
global _start   


section .text

; Program Entry Point
_start:

	; Print Hello World
	mov eax, 0x4          ; write() system call
	mov ebx, 0x1          ; Instructuring stdout
	mov ecx, message      ; String to write
	mov edx, mlen         ; String length
	int 0x80

	; Exit Func
	mov eax, 0x1          ; exit() system call
	mov ebx, 0x5          ; Status
	int 0x80              ; Interrupt func to call system calls


section .data

	message:  db  "Hello World!"
	mlen	    equ $-message         ; String length calculation
  
  
