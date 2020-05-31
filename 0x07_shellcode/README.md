# Shellcode

## Shellcoding Process
# 1) Create .nasm

```asm
; Simple Exit Program

global _start			

section .text
_start:

    	mov eax, 1
	    mov ebx, 10
	    int 0x80
```

