import random


def guess_number():

    correct_number = random.randint(1, 100)
    
    for attempt in range(1, 6):
       
            guess = int(input(f"Спроба {attempt} з 5: Введіть число від 1 до 100: "))

            if guess == correct_number:
                print("Вітаємо! Ви вгадали правильне число.")
                return
    
            elif guess > correct_number:
                print("Занадто високо!")
            else:
                print("Занадто низько!")

    print(f"Вибачте, y вас закінчилися спроби. Правильний номер був {correct_number}.")
guess_number()
