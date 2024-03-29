set -e
defaultExtension="--javascript"
eslint="--no-eslint"
appDir="--no-experimental-app"
appFolder=false
srcDir="--no-src-dir"
srcFolder=''
pkgMgr="--use-npm"
appFolder=false

value=''
for n in $(seq 1 $#); 
do
  if [[ $1 == "ts" ]]
  then  
  defaultExtension='--typescript'
  elif [[ $1 == "lint" ]]
  then  
  eslint='--eslint'
  elif [[ $1 == "app" ]]
  then  
  appDir='--experimental-app'
  appFolder=true
  elif [[ $1 == "src" ]]
  then  
  srcDir='--src-dir'
  srcFolder="/src"
  elif [[ $1 == "pnpm" ]]
  then  
  pkgMgr='--use-pnpm'
  fi
  shift
done
query="$defaultExtension $eslint $appDir $srcDir $pkgMgr --import-alias @/*"
echo "Installing NextJs..."
npx create-next-app@13.1.6 . $query
echo "Installing TailwiindCSS..."
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
tailwindConfig='/** @type {import(tailwindcss).Config} */
module.exports = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx}",
    "./src/**/*.{js,ts,jsx,tsx}",
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
'
echo "$tailwindConfig" > tailwind.config.js

tailwindInit="@tailwind base;
@tailwind components;
@tailwind utilities;"


index='import Head from "next/head";

export default function Home() {
  return (
    <>
      <Head>
        <title>Create Next App</title>
        <meta name="description" content="Generated by create next app" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <div>Hello World</div>
    </>
  );
}
'
appindex='export default function Home() {
  return <div>Hello World</div>;
}
'
if [[ "$appFolder" = true ]]
then
echo "$tailwindInit" > ."$srcFolder"/app/globals.css
rm ."$srcFolder"/app/page.module.css
echo "$appindex" > ."$srcFolder"/app/page.*
else
echo "$index" > ."$srcFolder"/pages/index.*
echo "$tailwindInit" > ."$srcFolder"/styles/globals.css
rm ."$srcFolder"/styles/Home.module.css
fi

echo "Installing prettier plugin for Tailwind..."
npm install -D prettier prettier-plugin-tailwindcss
prettierConfig="module.exports = {
  plugins: [require('prettier-plugin-tailwindcss')],
}"
echo "$prettierConfig" > prettier.config.js


#Runs if git is installed on the hardware
git init
echo 'node_modules' > .gitignore
echo '.next' >> .gitignore
git add .
git commit -m "Initial commit"

code .

