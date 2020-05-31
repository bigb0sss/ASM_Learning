#include<stdio.h>
#include<string.h>

unsigned char shellcode[] = ( 
"\x31\xc0"          /* XOR EAX, EAX */
"\xb0\x01"          /* MOV AL, 0x1  */
"\x31\xdb"          /* XOR EBX, EBX */
"\xb3\x0a"          /* MOV BL, 0xa. */
"\xcd\x80");        /* INT 0x80     */

main() {
        printf("[+] Shellcode Length: %d\n", strlen(shellcode));
        int (*ret)() = (int(*)())shellcode;
        ret();        

}
