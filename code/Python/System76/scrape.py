from laptops_dic import laptop_dict_list_new
import requests
from bs4 import BeautifulSoup
from pprint import pprint


laptop_links = [
    'https://system76.com/laptops/pangolin#specs',
    'https://system76.com/laptops/galago#specs',
    'https://system76.com/laptops/lemur#specs',
    'https://system76.com/laptops/darter#specs',
    'https://system76.com/laptops/gazelle#specs',
    'https://system76.com/laptops/serval#specs',
]

laptop_dict_list = []
for laptop_link in laptop_links:
    res = requests.get(laptop_link)
    soup = BeautifulSoup(res.text, 'html.parser')
    tech_specs = soup.select('td')

    tsl = []
    for i in tech_specs:
        tsl.append(i.getText())

    laptop_dict_list.append(dict(zip(tsl[::2], tsl[1::2])))

for dic in laptop_dict_list:
    dic.pop('Operating System', None)
    dic.pop('Firmware', None)
    dic.pop('Dimensions', None)
    dic.pop('Weight', None)
    dic.pop('Audio', None)
    dic.pop('Camera', None)

pprint(laptop_dict_list)
for dic in laptop_dict_list:
    print(dic)

pprint(laptop_dict_list_new)



















