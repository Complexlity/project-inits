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
echo "$tailwindConfig" > tailwind.config.cjs

tailwindInit="@tailwind base;
@tailwind components;
@tailwind utilities;"
echo "$tailwindInit" > ./src/index.css

rm src/App.css

appJSX='
function App() {
  return (
    <div className="App">
    </div>
  )
}

export default App'
echo "$appJSX" > src/App.jsx

npm install -D prettier prettier-plugin-tailwindcss
prettierConfig="module.exports = {
  plugins: [require('prettier-plugin-tailwindcss')],
}"
echo "$prettierConfig" > prettier.config.cjs


#Runs if git is installed on the hardware
git init
echo 'node_modules' > .gitignore
git add .
git commit -m "Initial commit"

code .

