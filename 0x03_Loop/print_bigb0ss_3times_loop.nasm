; Executable name : print_bigb0ss_3times_loop
; Version         : 1.0
; Created date    : 05/28/2020
; Last update     : 05/28/2020
; Author          : bigb0ss
; Description.    : Print "bigb0ss" x3 times with ECX + Loop
;
; Purpose:

global _start

section .text
_start:
        jmp entry
        
entry:
        mov ecx, 0x3        ; Setting ECX our loop purposes
        
print:
        push ecx            ; Storing the current state of ECX
        
        mov eax, 0x4        ; Calling write() syscall
        mov ebx, 1
        mov ecx, message
        mov edx, mlen
        int 0x80
        
        pop ecx             ; Restoring the ECX state
        loop print          ; Looping through ECX value until it become "0"
        
        mov eax, 0x1        ; Calling exit() syscall
        mov ebx, 0xa
        int 0x80

section .data

        message: db "bigb0ss "
        mlen     equ $-message
