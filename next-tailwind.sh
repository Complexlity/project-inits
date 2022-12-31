set -e
defaultExtension="--javascript"

value=''
if [[ $1 == "ts" ]]
then  
defaultExtension='--typescript'
fi
npx create-next-app@latest . "$defaultExtension" --eslint
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
tailwindConfig='/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}'
echo "$tailwindConfig" > tailwind.config.js

tailwindInit="@tailwind base;
@tailwind components;
@tailwind utilities;"
echo "$tailwindInit" > ./styles/globals.css
rm ./styles/Home.module.css

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
echo "$index" > ./pages/index.*


npm install -D prettier prettier-plugin-tailwindcss
prettierConfig="module.exports = {
  plugins: [require('prettier-plugin-tailwindcss')],
}"
echo "$prettierConfig" > prettier.config.js


#Runs if git is installed on the hardware
git init
echo 'node_modules' > .gitignore
git add .
git commit -m "Initial commit"

code .
