#Given the below class:
class Cat:
    species = 'mammal'
    def __init__(self, name, age):
        self.name = name
        self.age = age


# 1 Instantiate the Cat object with 3 cats
Buddy = Cat('Buddy', 8)
Beep = Cat('Beep', 11)
Scoop = Cat('Scoop', 10)

cats = [Buddy, Beep, Scoop]
# 2 Create a function that finds the oldest cat
def find_oldest(cat_list):

	oldest_cat_name = ''
	oldest_cat_age = 0

	for cat in cat_list:
		if cat.age > oldest_cat_age:
			oldest_cat_age = cat.age
			oldest_cat_name = cat.name
			
	return oldest_cat_name, oldest_cat_age

# 3 Print out: "The oldest cat is x years old.". x will be the oldest cat age by using the function in #2
print(f"The oldest cat {find_oldest(cats)[0]}, is {find_oldest(cats)[1]} years old.")