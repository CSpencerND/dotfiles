#!/usr/bin/env python

import os
import re

cwd = os.getcwd()

imports = ""
image_imports = []

for file in os.listdir(cwd):
    if re.search(r"\.(jpg|png|gif|webp|avif)$", file):
        file_name_without_extension = (
            re.sub(r"\.[^/.]+$", "", file).replace("-", "").replace("[^\w]", "")
        )
        imports += f'import {file_name_without_extension} from "./{file}";\n'
        image_imports.append(file_name_without_extension)

output = f"{imports}\nconst imageImports = [{', '.join(image_imports)}];\n\nexport default imageImports;\n"

if os.path.exists("index.js"):
    answer = input("index.js already exists. Do you want to overwrite it? (y/N) ")
    if answer.lower() == "y":
        with open("index.js", "w") as f:
            f.write(output)
    else:
        print("Aborted")
else:
    with open("index.js", "w") as f:
        f.write(output)
