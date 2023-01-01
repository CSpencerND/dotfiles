#!/usr/bin/env node

const fs = require('fs');
const readline = require('readline');

const cwd = process.cwd();

let imports = '';
const imageImportsTest = [];

fs.readdirSync(cwd).forEach(file => {
  if (/\.(jpg|png|gif|webp|avif)$/.test(file)) {
    const fileNameWithoutExtension = file.replace(/\.[^/.]+$/, '').replace(/-/g, '').replace(/[^\w]/g, '');
    imports += `import ${fileNameWithoutExtension} from "./${file}";\n`;
    imageImportsTest.push(`[${fileNameWithoutExtension}, "${fileNameWithoutExtension}"]`);
  }
});

const output = `${imports}\nconst imageImportsTest = [\n  ${imageImportsTest.join(',\n  ')}\n];\n\nexport default imageImportsTest;\n`;

if (fs.existsSync('index.ts')) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });
  rl.question('index.ts already exists. Do you want to overwrite it? (y/N) ', answer => {
    if (answer.toLowerCase() === 'y') {
      fs.writeFileSync('index.ts', output);
    } else {
      console.log('Aborted');
    }
    rl.close();
  });
} else {
  fs.writeFileSync('index.ts', output);
}

