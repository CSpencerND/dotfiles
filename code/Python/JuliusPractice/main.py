from pprint import pprint
import numpy as np

# flt = 5.5
# num = int(flt)
# print(num)

# int 5
# str 'hello
# float 5.5
# bool True

# list
# dict
# set
# tuple

lst1 = [1, 2, 3]
# lst2 = [2, 3, 4, 5]
# st = {1, 2, 3}
# tup = (1, 2, 3)
# lst3 = lst1 + lst2
# print(lst3)
# st2 = set(lst3)
# print(st2)

friends = {'names': ['julio', 'rob', 'chris'], 'ages': [34, 33, 34]}

# if 5 == 5:
#     print('Five equals five')
#
# if 2 in lst1:
#     print("Two is in the list")
#
# if not 8 in lst1:
#     print("Eight is not in the list")
#
# if not lst1[0] == 1:
#     print("HELLO")
# else:
#     print("HELLO")
#
# if type(5) is int:
#     print("Five is and integer")

# if 4 not in lst1:
#     lst1.append(4)
# print(lst1)

# if 4 in lst1:
#     lst1.pop(4)
#
# del lst1[2]
# lst1.pop(1)


animals = {}
animals['felines'] = {'cat': 'tabby', 'tiger': 'bengal', 'lion': 'african'}
animals['canines'] = {'dog': 'chihuahua', 'wolf': 'grey', 'fox': 'red'}

print(animals)

a = [7, 8, 8, 8, 6, 7, 4, 5, 6, 9]
print(np.mean(a))

b1 = [95, 60, 84, 77, 67, 83, 83, 94]
b2 = [79, 70, 79, 94, 80, 83, 90, 73]
print(np.mean(b1 + b2))

c = [13, 14, 15, 10, 11, 'x', 14, 13, 10, 10]


def find_missing_number(num_list, list_mean):
    total = len(num_list) * list_mean
    for num in num_list:
        if type(num) is int:
            total -= num
    return total


x = find_missing_number(c, 12)
print(x)
