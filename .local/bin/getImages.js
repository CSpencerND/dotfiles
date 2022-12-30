#!/usr/bin/env node

const fs = require("fs")

const files = fs.readdirSync(".")
const imageFiles = files.filter((file) => {
    return /\.(jpg|png|gif|webp|avif)$/.test(file)
})

const altFromSrc = (src) => {
    return (
        src.split("/").pop().split(".").shift().replace(/-/g, " ") || "t-shirt"
    )
}

const imageData = imageFiles.map((file) => {
    const name = altFromSrc(file)
    return {
        src: file,
        alt: name,
    }
})

fs.writeFileSync(
    "index.js",
    `module.exports = ${JSON.stringify(imageData, null, 2)}`
)
