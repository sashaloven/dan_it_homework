#!/bin/bash

filename=$1

if [[ -f $filename ]]; then
	while read line
	do
		echo $line
	done < $filename

else 
	echo "File do not exist"
fi
