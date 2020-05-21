; movingData.nasm
;
; Author: bigb0ss
;
; [*] This is just example of mine. You can modify anything to play the data.


; Global Entry Point

global _start

section .text
_start

  ; mov - Move data into register  
  mov eax, 0xaabbccdd
  mov al, 0xff                ; a-low
  mov ah, 0xff                ; a-high
  mov ax, 0xffff              
  mov ebx, 0xaabbccdd
  mov bl, 0xdd
  mov bh, 0xdd
  mov bx, 0xdddd
  
  mov ebx, 0x00
  mov ecx, 0x00
  
  ; mov - Move register into register
  mov ebx, eax
  mov cl, al
  mov ch, ah
  mov cx, ax
  
  mov eax, 0x00
  
  ; mov - Move memory into register
  mov al, [test]              ; Moving fist test value (0x11) into al
  mov ah, [test +1]           ; Moving second test value (0x22) into ah
  mov bl, [test +2]           ; Moving third test value (0x33) into bl
  mov bh, [test +3]           ; Moving forth test value (0x44) into bh
  mov ecx, [test]
  
  mov eax, 0x00
  mov ebx, 0x00
  
  ; mov - Move register into memory
  mov eax, 0xAABBCCDD
  mov byte [test], al         ; Moving al (0xDD) into first byte of test
  mov word [test], ax         ; Moving ax (0xCCDD) into first and second bytes of test
  mov dwrod [test], eax       ; Moving eax (0xAABBCCDD) into 1,2,3 and 4th bytes of test
  
  ; Load Effective Address (LEA)
  lea ebx, [test]
  lea ecx, [ebx]
  
  ; Exchange (XCHG)
  mov eax, 0x11223344
  mov ebx, 0xaabbccdd
  xchg eax, ebx
  
  ; exit()
  mov eax, 1
  mov ebx, 0
  int 0x80


section .data

test:   db 0x11, 0x22, 0x33, 0x44
