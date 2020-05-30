; Executable name : helloWorld_2
; Version         : 1.0
; Created date    : 05/20/2020
; Last update     : 05/20/2020
; Author          : bigb0ss
; Description.    : Print "Hello World!"
;
;

section .data           ; Section containing initializing data

message:  db  "Hello World!"
msglen: equ $-message

section .bss            ; Section containing uninitialized data

section .text           ; section containing code

global _start           ; Global entry point

_start:
      nop               ; Nopsled
      mov eax, 4        ; sys_write syscall
      mov ebx, 1        ; fd (File Descriptor): Standard Output
      mov ecx, message  ; Pass offset of the message
      mov edx, msglen   ; Pass the length of the message
      int 80H           ; Make syscall to ouput the text to stdout
      
      mov eax, 1        ; Specify exit() syscall
      mov ebx, 0        ; Return a status code of zero
      int 80H           ; Make syscall to terminate the program
      
      
