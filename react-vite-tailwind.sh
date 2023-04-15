
#!/bin/bash

set -euo pipefail # enable strict mode

# Initialize variables
default_template="react"
typescript=""
tailwind_init="@tailwind base;\n@tailwind components;\n@tailwind utilities;\n"
app_code='
function App() {
  return (
    <div className="App">
      Hello World
    </div>
  );
}

export default App;'
prettier_config='module.exports = {
  plugins: [require("prettier-plugin-tailwindcss")],
};'

# Parse command line arguments
if [[ "${1:-}" == "ts" ]]; then
  typescript=" with TypeScript"
  default_template+="-$1"
fi

# Install and configure Vite with React template
echo "Installing React${typescript}..."
npm create vite@latest . -- --template "$default_template"

# Install and configure TailwindCSS
echo "Installing TailwindCSS..."
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Create TailwindCSS configuration file
tailwind_config='/** @type {import("tailwindcss").Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};'
echo "$tailwind_config" > tailwind.config.js
echo "$tailwind_config" > tailwind.config.cjs

# Create TailwindCSS CSS file
echo -e "$tailwind_init" > ./src/index.css
rm src/App.css

# Create React app file
echo "$app_code" > src/App.jsx

# Install and configure Prettier with TailwindCSS plugin
echo "Installing Prettier for Tailwind..."
npm install -D prettier prettier-plugin-tailwindcss
echo "$prettier_config" > prettier.config.cjs

# Initialize Git repository (if installed)
if command -v git >/dev/null 2>&1; then
  git init
  echo 'node_modules' > .gitignore
  git add .
  git commit -m "Initial commit"
fi

# Open project in default code editor
code .
