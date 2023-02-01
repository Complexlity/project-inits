set -e
#Assumes node.js and npm are installed on the hardware
npm init -y
echo "Installing TailwindCSS..."
npm install -D tailwindcss
npx tailwindcss init
mkdir css
mkdir js
touch index.html input.css css/styles.css js/main.js
projectName=${PWD##*/} 
partPackageJSON='{
  "name": "'
echo -n "$partPackageJSON" > package.json
echo -n $projectName >> package.json
partPackageJSON='",
  "version": "1.0.0",
  "description": "",
  "main": "js/main.js",
  "scripts": {
    "build": "npx tailwindcss -i input.css -o css/styles.css",
    "watch": "npx tailwindcss -i input.css -o css/styles.css --watch"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "tailwindcss": "^3.2.1"
  }
}
'
echo "$partPackageJSON" >> package.json
tailwindInit="@tailwind base;\n@tailwind components;\n@tailwind utilities;"
echo -e $tailwindInit > input.css
tailwindConfig='module.exports = {
  content: ["./*.html"],
  theme: {
     screens: {
      sm: "480px",
      md: "768px",
      mg: "976px",
      xl: "1440px"
    },
    extend: {},
  },
  plugins: [],
}
'
echo "$tailwindConfig" > tailwind.config.js
htmlInit='<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/styles.css">
    <script src="js/main.js" defer></script>
</head>
<body>
    
</body>
</html>'

echo "Installing Prettier for Tailwind..."
npm install -D prettier prettier-plugin-tailwindcss
prettierConfig="module.exports = {
  plugins: [require('prettier-plugin-tailwindcss')],
}"
echo "$prettierConfig" > prettier.config.js

echo "$htmlInit" > index.html

#Runs if git is installed on the hardware
git init
echo 'node_modules' > .gitignore
git add .
git commit -m "Initial commit"

#optionally runs if vs-code is installed and added to path on the hardware
code .
