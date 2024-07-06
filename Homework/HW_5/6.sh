#!/bin/bash

reverse_sentence() {
    sentence="$1"
    read -ra words <<< "$sentence"
    for (( i=${#words[@]}-1; i>=0; i-- )); do
        echo -n "${words[i]} "
    done
    echo
}

read -p "Enter a sentence: " sentence

reverse_sentence "$sentence"
