#!/usr/bin/env python3

import sys

current_year = None
current_max_temp = None

for line in sys.stdin:
    line_year, line_temp_str = line.strip().split("\t")
    line_temp = int(line_temp_str)
    if current_year == line_year:
        if line_temp > current_max_temp:
            current_max_temp = line_temp
    else:
        if current_year:
            print(current_year, current_max_temp, sep="\t")
        current_year, current_max_temp = line_year, line_temp

# print last year
if current_year:
    print(current_year, current_max_temp, sep="\t")
