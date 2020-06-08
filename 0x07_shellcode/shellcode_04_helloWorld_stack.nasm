; Executable name : shellcode_04_helloWorld_stack
; Version         : 1.0
; Created date    : 05/31/2020
; Last update     : 05/31/2020
; Author          : bigb0ss
; Description.    : Print "Hello World\n" using shellcode
;                   This will directly write the string values on the stack. 
;                   - The string should be added reverse order since the stack grows from the small addr to big.
;
;                   [Python Example] 
;                   code = 'Hello World\n'
;                   code[::-1]
;                   code[::-1].encode('hex')
;

global _start

section .text

_start:

    	; write() syscall
    	xor eax, eax                          ; Set EAX to zero
  	mov al, 0x4                           ; Adding "4" to AL (= lower byte of EAX)
  	xor ebx, ebx                          ; Set EBX to zero
  	mov bl, 0x1                           ; Adding "1" to AL (= lower byte of EBX)

    	xor edx, edx                          ; Set EDX to zero
        push edx                              ; Putting the EDX on the stack. We are doing this for string null byte at the end.

	push 0x0a646c72                       ; Reverse order of "Hello World\n"
	push 0x6f57206f
	push 0x6c6c6548

	mov ecx, esp                          ; Putting the current ESP to ECX to align our write() syscall

	mov dl, 12			      ; Adding a length of "Hello World\n"
	int 0x80


        ; exit() syscall
	xor eax, eax
	mov al, 0x1
	xor ebx, ebx
	int 0x80
