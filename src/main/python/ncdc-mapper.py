#!/usr/bin/env python3

import sys

for line in sys.stdin:
    year = line[15:19]
    temperature = int(line[87:92])
    quality = line[92:93]
    if temperature != 9999 and quality in "01459":
        print(year, temperature, sep="\t")

