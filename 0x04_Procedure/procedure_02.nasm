; Executable name : procedure_02
; Version         : 1.0
; Created date    : 05/30/2020
; Last update     : 05/30/2020
; Author          : bigb0ss
; Description.    : Print "bigb0ss" 3 time using Procedure 
;                   We will be leveraing the following procedure functions:
;
;                   * Saving / Restoring Registers
;                   -	PUSHAD / POPAD
;
;                   * Saving / Restoring Flags
;                   - PUSHFD / POPFD
;
;                   * Saving / Restoring
;                 	- Enter / LEAVE + RET
;
; Purpose:

global _start

section .text

Procedure_print:

      push ebp                  ; Saves the current frame pointer
      mov ebp, esp              ; Moves the top of the stack to EBP

      mov eax, 0x04             ; Calling write() syscall
      mov ebx, 1
      mov ecx, message
      mov edx, mlen
      int 0x80
      
      mov esp, ebp
      pop ebp                   ; Restoring the frame pointer
      
      ; leave                   ; "mov esp, ebp" and "pop ebp" can be replaced with "leave"      
      ret                       ; RET tells CPU the procedure ends
      
_start:

      mov ecx, 0x03             ; Adding 3 to ECX for our printing "bigb0ss" 3 times purposes
      
helloWorld_print:

      pushad                    ; Saving registers
      pushfd                    ; Saving flags
      
      call Procedure_print      ; Call Procedure_print to do the write job

      popfd                     ; Restoring flags
      popad                     ; Restoring registers
      
      loop hellowWorld_print    ; Looping through the hellowWorld_print until ECX becomes "0"
      
      mov eax, 0x01             ; Calling exit() syscall
      mov ebx, 0x0a
      int 0x80
      
section .data

        message: db "bigb0ss "
        mlen     equ $-message
