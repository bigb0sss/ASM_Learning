#!/usr/bin/python
#
# Description: Change string values to hex in reverse order
# Author: bigb0ss
#

import sys

if len(sys.argv) >= 2:
  string = sys.argv[1]
else:
  print "[+] Usage: " + sys.argv[0] + " <String>"
  exit(1)
  
print "[+] String Length: " + str(len(string))

stringList = [string[i:i+4] for i in range(0, len(string), 4)]

for c in stringList[::-1]:
  print c[::-1] + " : 0x" + str(c[::-1].encode('hex'))
