#!/bin/bash
# This script inserts a line PKG_USE_MIPS16:=0 after every non-comment line in a file
# Usage: bash insert_line.sh filename

files=(feeds/packages/net/adguardhome/Makefile feeds/packages/net/frp/Makefile)

for file in ${files[@]}
do
    n=1

    while read -r line
    do
        if [[ ! $line =~ ^# ]]; then
            sed -i "$n aPKG_USE_MIPS16:=0" $file
            break
        fi
        n=$(($n+1))
    done < "$file"
done