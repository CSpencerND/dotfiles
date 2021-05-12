from pprint import pprint
from collections import Counter
fibo_list = ['1']

n1 = 0
n2 = 1
n3 = n1 + n2
# print(n1, n2, n3, sep='\n')
while n3 < 100000000000000000000000000000000000000000000000000000000000:
  n1 += n2
  n2 += n3
  n3 = n1 + n2
  fibo_list.append(str(n2))
  fibo_list.append(str(n3))

# pprint(fibo_list)

digit_list = [len(num) for num in fibo_list]

# pprint(digit_list)

reps = Counter(digit_list).values()
# print(reps)

fun = list(reps)
print(fun)