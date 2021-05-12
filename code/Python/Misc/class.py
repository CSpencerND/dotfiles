class User:
    def __init__(self, name, email, age):
        self.name = name
        self.email = email
        self.age = age
        
    def greeting(self):
        return f'My name is {self.name} and I am {self.age}'
        
    def has_birthday(self):
        self.age +=1
        
        
brad = User('Brad', 'brad@gmail.com', 37)

brad.has_birthday()
print(brad.greeting())



class Customer(User):
    def __init__(self, name, email, age):
        self.name = name
        self.email = email
        self.age = age
        self.balance = 0
        
    def set_balance(self, balance):
        self.balance = balance
        
    def greeting(self):
        return f'My name is {self.name} and I am {self.age} and balance is {self.balance}'
    
    
jneta = Customer('Janet', 'janet@ahoo.com', 25)

janet.set_balance(500)
print(janet.greeting())