#!/bin/bash
# This script inserts a line PKG_USE_MIPS16:=0 after every non-comment line in a file
# Usage: bash insert_line.sh filename

files=(feeds/packages/net/adguardhome/Makefile feeds/packages/net/frp/Makefile)

for file in ${files[@]}
do
    tempfile=$(mktemp)

    while read -r line; do
        echo "$line" >> $tempfile
        if [[ ! $line =~ ^# ]]; then
            echo "PKG_USE_MIPS16:=0" >> $tempfile
        fi
    done < "$file"

    mv $tempfile $file
done