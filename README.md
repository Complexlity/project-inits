The tailwind.sh file runs all the necessary tailwind commands so you can immediately start your project

System Requirements:
1. Npm and Node.js must be installed
2. Should be run on a linux terminal
3. Have Git installed (optional)
4. Have vs-code installed and installed to path (optional)

How to use
1. Create  a new project folder
2. Enter the newly created folder (using cd command)
3. Copy the "tailwind.sh" into the new folder
4. Run " bash tailwind.sh " in that folder
5. Go into "package.json" and give the project the correct name

What the command does
1. installs tailwind css
2. Creates all necessary html, css and js files
3. Creates "build" and "watch" commands in package.json file
4. Links index.html to the created css and js files
5. Link configures tailwind to watch all html files created in that folder
