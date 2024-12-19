#!/bin/bash

echo -n "Enter filename: "
read filename

if [[ -f $filename ]]
then 
	echo "The file $filename exist"
else
	echo "The file '$filename' does not exist."
fi	
