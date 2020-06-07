; Executable name : libc_01
; Version         : 1.0
; Created date    : 05/30/2020
; Last update     : 05/30/2020
; Author          : bigb0ss
; Description.    : Print "Hello World!" using libc
;
;

; Defining libc functions that I want to use

extern printf
extern exit


global main                  ; For libc, use the starting point as "main" instead of "_start"

section .text
main

      push message           ; Pushing the message location on the stack
      call printf            ; Calling the printf from the libc
      add esp, 0x4           ; Adjusting the stack address
      mov eax, 0xa
      call exit              ; Calling the exit from the libc
      
section .data

      message: db "Hello World!", 0xA, 0x00
      mlen     equ $-message
