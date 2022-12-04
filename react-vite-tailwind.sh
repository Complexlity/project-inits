set -e
npm create vite@latest . -- --template react
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
tailwindConfig='/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}'

echo "$tailwindConfig" >> tailwind.config.cjs

tailwindInit="@tailwind base;\n@tailwind components;\n@tailwind utilities;\n"

sed -i "1i$tailwindInit" ./src/index.css

git add .
git commit -m "Initial commit"

code .

