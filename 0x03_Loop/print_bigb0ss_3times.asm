; Executable name : print_bigb0ss_3times
; Version         : 1.0
; Created date    : 05/25/2020
; Last update     : 05/25/2020
; Author          : bigb0ss
; Description.    : Print "bigb0ss" x3 times
;
; Purpose:

global _start

section .text
_start:
        jmp entry
        
entry:
        mov eax, 0x3        ; Setting EAX to 0x3 for our loop purposes
        
print:
        push eax            ; Storing the current state of EAX
        
        mov eax, 0x4        ; Calling write() syscall
        mov ebx, 1
        mov ecx, message
        mov edx, mlen
        int 0x80
        
        pop eax             ; Restoring the EAX state
        dec eax             ; Decrementing by 1
        jnz print           ; If the EAX is not equal to 0, then go back to print:
        
        mov eax, 0x1        ; Calling exit() syscall
        mov ebx, 0xa
        int 0x80

section .data

        message: db "bigb0ss "
        mlen     equ $-message
