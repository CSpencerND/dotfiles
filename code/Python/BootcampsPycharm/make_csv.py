from bootcamp_matrix import *
import csv

bootcamp_list = [
    app_acad, flatiron, gnl_assy, coding_dojo, hack_react, lambda_, rithm
    ]
filename = 'bootcamps.csv'
with open(filename, 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow([
        'Bootcamp', 'Duration', 'Schedule',
        'Payment Options', 'Curriculum'
        ])
    for bootcamp in bootcamp_list:
        writer.writerow([
            bootcamp.name, bootcamp.duration, bootcamp.schedule, 
            bootcamp.cost, bootcamp.langs
        ])
