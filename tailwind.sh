#!/bin/bash
set -e

# Initializes a new Node.js project
initialize_node_project() {
  npm init -y
}

# Installs TailwindCSS and creates the configuration files
install_tailwindcss() {
  echo "Installing TailwindCSS..."
  npm install -D tailwindcss

  npx tailwindcss init

  mkdir -p css js

  touch index.html input.css css/styles.css js/main.js

  local project_name=${PWD##*/}

  cat > package.json <<EOF
{
  "name": "$project_name",
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
EOF

  cat > input.css <<EOF
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

  cat > tailwind.config.js <<EOF
module.exports = {
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
EOF

  cat > index.html <<EOF
<!DOCTYPE html>
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
  Hello World  
</body>
</html>
EOF
}

# Installs Prettier and the TailwindCSS plugin
install_prettier() {
  echo "Installing Prettier for Tailwind..."
  npm install -D prettier prettier-plugin-tailwindcss

  cat > prettier.config.js <<EOF
module.exports = {
  plugins: [require('prettier-plugin-tailwindcss')],
}
EOF
}

# Initializes a new Git repository
initialize_git_repository() {
  if command -v git &> /dev/null; then
    git init

    echo 'node_modules' > .gitignore

    git add --all
    git commit -m "Initial commit"
  fi
}



initialize_node_project
install_tailwindcss
install_prettier
initialize_git_repository
code .