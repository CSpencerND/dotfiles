password = 'helloworld'

passInput = input('Please enter the password: ')
passInput = str(passInput)

if passInput == password:
    print('Access granted')
else:
    print('Access denied')
    
