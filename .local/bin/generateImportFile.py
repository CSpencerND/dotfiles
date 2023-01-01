#!/usr/bin/env python

import os
import re

cwd = os.getcwd()

imports = ""
image_imports_test = []

for file in os.listdir(cwd):
    if re.search(r"\.(jpg|png|gif|webp|avif)$", file):
        file_name_without_extension = (
            re.sub(r"\.[^/.]+$", "", file).replace("-", "").replace("[^\w]", "")
        )
        imports += f'import {file_name_without_extension} from "./{file}";\n'
        image_imports_test.append(f'[{file_name_without_extension}, "{file_name_without_extension}"]')

output = f"{imports}\nconst imageImportsTest = [{', '.join(image_imports_test)}];\nexport default imageImportsTest;"

if os.path.exists("index.ts"):
    answer = input("index.ts already exists. Do you want to overwrite it? (y/N) ")
    if answer.lower() == "y":
        with open("index.ts", "w") as f:
            f.write(output)
    else:
        print("Aborted")
else:
    with open("index.ts", "w") as f:
        f.write(output)
