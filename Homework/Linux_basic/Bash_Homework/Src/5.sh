#!/bin/bash

filename="$1"
location="$2"

if [[ -f $filename ]]
then
cp "$filename" "$location"
fi
