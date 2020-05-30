; Executable name : procedure_01
; Version         : 1.0
; Created date    : 05/30/2020
; Last update     : 05/30/2020
; Author          : bigb0ss
; Description.    : Print "bigb0ss" 3 time using Procedure
;
; Purpose:

global _start

section .text

Procedure_print:

      mov eax, 0x04        ; Calling write() syscall
      mov ebx, 1
      mov ecx, message
      mov edx, mlen
      int 0x80
      ret                  ; RET tells CPU the procedure ends
      
_start:

      mov ecx, 0x03        ; Adding 3 to ECX for our printing "bigb0ss" 3 times purposes
      
helloWorld_print:

      push ecx                  ; Saving the current ECX state on the stack
      call Procedure_print      ; Call Procedure_print to do the write job
      pop ecx                   ; Restoring back to the saved ECX state
      loop hellowWorld_print    ; Looping through the hellowWorld_print until ECX becomes "0"
      
      mov eax, 0x01             ; Calling exit() syscall
      mov ebx, 0x0a
      int 0x80
      
section .data

        message: db "bigb0ss "
        mlen     equ $-message
      
