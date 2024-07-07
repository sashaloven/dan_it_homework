#!/bin/bash

# Генеруємо випадкове число від 1 до 100
correct_number=$(( RANDOM % 100 + 1 ))
attempts=5

echo "Вгадайте число від 1 до 100, маєте 5 спроб"

for (( i=1; i<=$attempts; i++ ))
do
    read -p "Спроба $i: " guess

    if (( guess == correct_number )); then
        echo "Вітаємо! Ви вгадали правильне число."
        exit 0
    elif (( guess < correct_number )); then
        echo "Занадто низько."
    else
        echo "Занадто високо."
    fi
done

echo "Вибачте, у вас закінчилися спроби. Правильним числом було $correct_number."
exit 0

