set -e
npm init -y
npm install -D tailwindcss
npx tailwindcss init
mkdir css
mkdir js
touch index.html input.css css/styles.css js/main.js
tailwindInit="@tailwind base;\n@tailwind components;\n@tailwind utilities;"
echo -e $tailwindInit > input.css
tailwindConfig='module.exports = {
  content: ["./*.html"],
  theme: {
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
echo "$htmlInit" > index.html
git init
echo 'node_modules' > .gitignore
git add .
git commit -m "Initial commit"
code .
