#!/bin/bash

filename=$1

if [[ -f "$filename" ]]
then
    number_of_lines=$(wc -l < "$filename")
    echo "Lines in $filename is $number_of_lines"
fi
