# TheEldenLords

The best app ever.
Apparently we need a .env file with this: DISCORD_TOKEN=the_bot_token

First install the database. Then run the API. Lastly run the Discord bot.

We're programming in Python in Visual Studio Code.
For the API we'll use Python with fastapi.
DataGrip with SQLite for the database.
Frontend is Discord.

# Database Installation
--- You should have the entire project downloaded before you set up the database ---
- To get the database working properly, open up DataGrip.
- Create new project.
- Navigate to the Database folder, set that as your project.
- Add a data source and select SQLite. Make sure it's named eldenring.sqlite.
- If a console window doesn't appear, right click eldenring.sqlite and select query console.
- Go back to File Explorer and open up the databaseCommands.sql file. I'd open it up in Notepad.
- Copy all that code, go back to DataGrip, paste it into the console, select all, and press the run button.
- It should create the entire database. Also control + enter sometimes runs the code.

# Running the API
To run the API, navigate to the API folder and run this command in terminal.
- python -m uvicorn main:app --reload

# Running the Discord Bot
To run the Discord bot first make sure you have the right packages installed.
Navigate to the Discord Bot folder and run this command.
- pip install -r requirements.txt
