#!/usr/bin/env node

const fs = require("fs")
const path = require("path")

const cwd = process.cwd()

let imports = ""
const imageImportsTest = []

fs.readdirSync(cwd).forEach((file) => {
    if (/(\.jpg|\.png|\.gif|\.webp|\.avif)$/.test(file)) {
        const fileNameWithoutExtension = file
            .replace(/\.[^/.]+$/, "")
            .replace(/-/g, "")
            .replace(/[^\w]/g, "")
        imports += `import ${fileNameWithoutExtension} from "./${file}";\n`
        imageImportsTest.push(
            `[${fileNameWithoutExtension}, "${fileNameWithoutExtension}"]`
        )
    }
})

const output = `import { StaticImageData } from 'next/image';
${imports}
type ImageImport = [StaticImageData, string];
const imageImportsTest: ImageImport[] = [
  ${imageImportsTest.join(", ")}
];
export default imageImportsTest;`

if (fs.existsSync("index.ts")) {
    const answer = await new Promise((resolve) => {
        process.stdin.resume()
        process.stdin.setEncoding("utf8")
        process.stdout.write(
            "index.ts already exists. Do you want to overwrite it? (y/N) "
        )
        process.stdin.on("data", (text) => {
            resolve(text)
        })
    })

    if (answer.toLowerCase() === "y") {
        fs.writeFileSync("index.ts", output)
    } else {
        console.log("Aborted")
    }
} else {
    fs.writeFileSync("index.ts", output)
}
