#!/usr/bin/env node

const fs = require("fs")
const cwd = process.cwd()

let imports = ""
const initialImports = []

fs.readdir(cwd, (err, files) => {
    if (err) throw err

    // Loop through each file
    for (const file of files) {
        // Check if the file extension matches the desired ones using a regular expression
        if (/\.(jpg|png|gif|webp|avif)$/i.test(file)) {
            // Get the file name without the extension
            const fileNameWithoutExtension = file
                .replace(/\.[^.]+$/, "")
                .replace(/-/g, "")
                .replace(/[^\w]/g, "")

            // Add the import statement for the file
            imports += `import ${fileNameWithoutExtension} from "./${file}";\n`

            // Add the file to the initialImports array
            initialImports.push(
                `[${fileNameWithoutExtension}, "${fileNameWithoutExtension}"]`
            )
        }
    }

    // Create the output string
    const output = `import { ImageImport, ImageData } from "~/types";
${imports}
const initialImports: ImageImport[] = [
    ${initialImports.join(", ")}
]

const imageImports: ImageData[] = []

initialImports.forEach((imageImport) => {
    const imageData = imageImport[0]
    const alt: string = imageImport[1]

    imageData.alt = alt
    imageImports.push(imageData)
})

export default imageImports;`

    // Check if the index.ts file already exists
    fs.stat("index.ts", (error) => {
        if (error) {
            // If the file doesn't exist, create it and write the output to it
            fs.writeFile("index.ts", output, (writeError) => {
                if (writeError) throw writeError
            })
        } else {
            // If the file exists, ask the user if they want to overwrite it
            process.stdout.write(
                "index.ts already exists. Do you want to overwrite it? (y/N) "
            )
            process.stdin.on("data", (data) => {
                if (data.toString().trim().toLowerCase() === "y") {
                    // If the user wants to overwrite it, write the output to the file
                    fs.writeFile("index.ts", output, (writeError) => {
                        if (writeError) throw writeError
                    })
                } else {
                    console.log("Aborted")
                }
            })
        }
    })
})
