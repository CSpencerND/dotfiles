import random
from random import *


print('Hello, what is your name?')
name = input()
print(f'Well, {name}. I am thinking of a number between 1 and 20')

secretNum = randint(1, 20)

for guessesTaken in range(1, 7):
    try:
        print('Take a guess.')
            
        guess = int(input())

        if guess < secretNum:
            print('Your guess is too low. Try again.')
        elif guess > secretNum:
            print('Your guess is too high. Try again.')
        else:
            break
    except ValueError:
        print('That is not a number. Try again.')
    
if guess == secretNum:
    print(f'Ding ding ding!!! That\'s correct {name}!')
    print(f'You guessed my number in {str(guessesTaken)} guesses.')
else:
    print(f'Too many tries. The number I was thinking of was {str(secretNum)}.')
    
