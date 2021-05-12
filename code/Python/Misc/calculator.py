def add(num1, num2):
    result = num1 + num2
    print(result)

def sub(num1, num2):
    result = num1 - num2
    print(result)
    
def mult(num1, num2):
    result = num1 * num2
    print(result)
    
def div(num1, num2):
    result = num1 / num2
    print(result)
    

print('1. Add')
print('2. Sub')
print('3. Mult')
print('4. Div')
print('5. Exit')

while True:
    choice = int(input('enter choice: '))
    if choice >= 1 and choice <=4:
        num1 = int(input('Enter first number: '))
        num2 = int(input('Enter second number: '))
        if choice == 1:
            add(num1, num2)
        elif choice == 2:
            sub(num1, num2)
        elif choice == 3:
            mult(num1, num2)
        else:
            div(num1, num2)
    elif choice == 5:
        print('Buh byyyee.')
        break
    else:
        print('That is not a valid choice.')