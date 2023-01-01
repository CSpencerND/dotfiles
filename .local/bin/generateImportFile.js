#!/usr/bin/env node

const fs = require("fs")
const cwd = process.cwd()

let imports = ""
let imageImports = []

fs.readdirSync(cwd).forEach((file) => {
    if (/\.(jpg|png|gif|webp|avif)$/.test(file)) {
        let fileNameWithoutExtension = file
            .replace(/\.[^/.]+$/, "")
            .replace(/-/g, "")
            .replace(/[^\w]/g, "")
        imports += `import ${fileNameWithoutExtension} from "./${file}";\n`
        imageImports.push(fileNameWithoutExtension)
    }
})

const output = `${imports}\nconst imageImports = [${imageImports.join(
    ", "
)}];\n\nexport default imageImports;\n`

if (fs.existsSync("index.ts")) {
    const readline = require("readline").createInterface({
        input: process.stdin,
        output: process.stdout,
    })
    readline.question(
        "index.ts already exists. Do you want to overwrite it? (y/N)",
        (answer) => {
            if (answer === "" || answer.toLowerCase() === "n") {
                console.log("Aborted")
            } else if (answer.toLowerCase() === "y") {
                fs.writeFileSync("index.ts", output)
            }
            readline.close()
        }
    )
} else {
    fs.writeFileSync("index.ts", output)
}
