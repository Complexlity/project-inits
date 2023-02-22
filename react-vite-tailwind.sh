set -e
defaultTemplate="react"
typescript=""

value=''
if [[ $1 == "ts" ]]
then  
value="-$1"
typescript=" With TypeScript..."
fi
defaultTemplate+="$value"
echo "Installing React$typescript..."
npm create vite@latest . -- --template "$defaultTemplate"
echo "Installing TailwindCSS..."
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

app='
function App() {
  return (
    <div className="App">
    Hello World
    </div>
  )
}

export default App'
echo "$app" > src/App.*

echo "Installing Prettier for Tailwind..."
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

