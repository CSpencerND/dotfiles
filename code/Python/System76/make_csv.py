from system76_matrix import *
from laptops_dic import laptop_dict_list_new
from scrape import *
import csv

filename = 'system76_laptops.csv'
with open(filename, 'w', newline='') as f:
    fields = [
         'Model', 'Processor', 'Display', 'Graphics', 'Memory', 'Storage', 'Expansion', 'Input', 'Networking', 'Video Ports', 'Security', 'Battery', 'Charger'
              ]
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    writer.writerows(laptop_dict_list_new)

