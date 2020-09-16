#!/usr/bin/python
# Version         : 1.0
# Created date    : 09/15/2020
# Last update     : 09/15/2020
# Author          : bigb0ss
# Description     : ASM Compiler to Executable
# Example         : ./compilerX86.py -f <filename>
#                   ./compilerX86.py -f exploit (*You need have the "exploit.nasm" file in the same directory)

import sys
import argparse
import subprocess
import time
import string

""" Arguments """
parser = argparse.ArgumentParser(description = '[+] ASM Compiler')
parser.add_argument('-f', '--filename', help='\tFilename of the .nasm file')
args = parser.parse_args()

def banner():
    print(" ") 
    print("  ________  ________  _____ ______   ________  ___  ___       _______   ________     ___    ___ ________  ________         ")
    print(" |\   ____\|\   __  \|\   _ \  _   \|\   __  \|\  \|\  \     |\  ___ \ |\   __  \   |\  \  /  /|\   __  \|\   ____\        ")
    print(" \ \  \___|\ \  \|\  \ \  \\\\\__\ \  \ \  \|\  \ \  \ \  \    \ \   __/|\ \  \|\  \  \ \  \/  / | \  \|\  \ \  \___|      ")
    print("  \ \  \    \ \  \\\\\  \ \  \\\\|__| \  \ \   ____\ \  \ \  \    \ \  \_|/_\ \   _  _\  \ \    / / \ \   __  \ \  \____   ") 
    print("   \ \  \____\ \  \\\\\  \ \  \    \ \  \ \  \___|\ \  \ \  \____\ \  \_|\ \ \  \\\\  \|  /     \/   \ \  \|\  \ \  ___  \ ")
    print("    \ \_______\ \_______\ \__\    \ \__\ \__\    \ \__\ \_______\ \_______\ \__\\\\ _\ /  /\   \    \ \_______\ \_______\\ ")
    print("     \|_______|\|_______|\|__|     \|__|\|__|     \|__|\|_______|\|_______|\|__|\|__/__/ /\ __\    \|_______|\|_______|    ")
    print("                                                                                    |__|/ \|__|     [bigb0ss] v1.0         ")
    print("")
                                                                                                                    
def error():
    parser.print_help()
    exit(1)

def compile(a):
    # Assembling the .nasm file    
    subprocess.call(["nasm","-f","elf32","-o",a + ".o",a + ".nasm"])
    time.sleep(0.2)
    print "[+] Assemble: " + a + ".nasm"

    # Linking the out file
    subprocess.call(["ld","-z","execstack","-o",a,a + ".o"])
    time.sleep(0.2)
    print "[+] Linking: " + a + ".o"

# Referenced the "parse()" func for objdump parsing (https://github.com/dhn/bin2op/blob/master/bin2op.py)
def objdump(ob):
    obj = ["objdump", "-d", "-M", "intel", ob]
    
    out = subprocess.check_output(obj)
    out = out.split("Disassembly of section")[1]
    out = out.split("\n")[3:]
    #print out

    shellcode = ""

    for i in out:
        i = i.strip()

        tab = i.split('\t')
        if (len(tab) < 2):
            continue
        bytes = tab[1].strip()

        instruction = "."
        if (len(tab) == 3):
            instruction = tab[2].strip().decode("utf-8")

        bytes = bytes.split(' ')
        c = ""
        for byte in bytes:
            c += "\\x" + byte.decode("utf-8")

        shellcode += c
    out = shellcode
    print '[+] Shellcode: ' + '"' + out + '"'

    # Adding shellcode to shellcode.c
    outShellcode = ''
    outShellcode+= '#include<stdio.h>\n'
    outShellcode+= '#include<string.h>\n'
    outShellcode+= '\n'
    outShellcode+= 'unsigned char code[] = \ \n'
    outShellcode+= '"{0}";'.format(out)
    outShellcode+= '\n'
    outShellcode+= 'main()\n' 
    outShellcode+= '{\n'
    outShellcode+= 'printf("Shellcode Length:  %d", strlen(code));\n'
    outShellcode+= '\tint (*ret)() = (int(*)())code;\n'
    outShellcode+= '\tret();\n'
    outShellcode+= '}\n'   
    #print outShellcode

    # Creating shellcode.c
    filename = "shellcode.c"
    outfile = open(filename, 'w')
    outfile.write(outShellcode)
    outfile.close()
    print "[+] Creating File: shellcode.c"

    # Compiling shellcode.c
    print "[*] gcc warning (if any):\n"
    subprocess.call(["gcc", "-fno-stack-protector", "-z", "execstack", filename, "-o", "shellcode"])
    print ""
    print "[+] Compiling Executable: shellcode"
    print "[+] Enjoy!"

if __name__ == "__main__":
    banner()

    inputFile = args.filename if args.filename != None else error()
    
    compile(inputFile)
    time.sleep(0.2)
    objdump(inputFile)
