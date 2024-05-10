#!/usr/bin/env bash

production_dependencies=(
	"@react-hookz/web"
	"framer-motion"
	"geist"
	"plaiceholder"
	"sharp"
	"sonner"
	"vaul"
	"zustand"
)

development_dependencies=(
	"@tailwindcss/typography"
	"@tailwindcss/container-queries"
	"eslint-config-prettier"
	"knip"
	"prettier"
	"prettier-plugin-tailwindcss"
	"tailwind-variants"
)

if [ ! -f package.json ]; then
	echo "No package.json found. Please run this script from the root of a JavaScript project."
	exit 1
fi

if ! command -v pnpm &>/dev/null; then
	echo "pnpm could not be found, please install it first."
	exit 1
fi

echo "Installing production dependencies..."
if ! pnpm add "${production_dependencies[@]}"; then
	echo "Failed to install production dependencies."
	exit 1
fi

echo "Installing development dependencies..."
if ! pnpm add -D "${development_dependencies[@]}"; then
	echo "Failed to install development dependencies."
	exit 1
fi

echo "Creating prettier.config.js..."
cat >prettier.config.js <<EOF
/** @type {import("prettier").Config} */
module.exports = {
    tabWidth: 4,
    singleQuote: false,
    printWidth: 72,
    singleAttributePerLine: true,
    plugins: ["prettier-plugin-tailwindcss"],
    tailwindFunctions: ["clsx", "twMerge", "cn", "tv", "tw"],
    tailwindConfig: "./tailwind.config.ts",
};
EOF

echo "Updating .eslintrc.json..."
cat >.eslintrc.json <<EOF
{
    "extends": [
        "next/core-web-vitals",
        "prettier"
    ],
    "rules": {
        "jsx-a11y/alt-text": "off"
    }
}
EOF

echo "Updating .gitignore..."
printf "\n# vim session\nSession.vim\n" >>.gitignore

echo "Setup complete."
