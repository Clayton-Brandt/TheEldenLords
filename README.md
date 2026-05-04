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

# Setting up the Discord Bot
First you will need a discord bot of your own. But before that make your own personal Discord server.
- First go to Discord Developer Portal (you might need to sign in, if you already haven't) 
then click on "New Application".
- Name the new application elden_ring just in case.
- Go to the "Bot" tab
- Under Privileged Gateway Intents, enable: Server Members Intent & Message Content Intent
- Lastly, copy the Discord Token, we will use this later
- Then go to OAuth2 and then URL Generator. Give it these bot permissions:
- View channels, send messages, embed links, read message history, use slash commands
- For scopes, only select bot
- Next make a copy of the Discord Bot project for yourself, or if you already have one, make sure you have a copy of main.py, api.py, and a .env file
- The discord token you have, copy and paste it in the .env file. You'll need quotations around the token. No spaces. You can open the .env file in Notepad.
- Now you will need two terminals open, one for the API and the other for the bot
- In the first terminal for the API, make sure your directory is in the API folder then run in the terminal: python -m uvicorn main:app --reload
- In the second terminal for the discord bot, make sure you are in the Discord Bot folder, then in the terminal run: python main.py
- Invite your bot to your discord server
- Now with everything booted up you have a list of commands you can use

* just as a note, if something says (boss id), that is the number associated with the boss from 2 through 16 (skip 1)
* Also if you don't know what you want the bot to do, check the database. It'll have all the information you might want.
- !bosses
- !boss (boss id)
- !searchboss (name of boss)
- !lore (boss id)
- !prereq (boss id)
- !stats (boss id)
- !resist (boss id)
- !weak (boss id)
- !rewards (boss id)
- !helpboss (boss id)
- !progress (user id)
- !completion (run id) (boss id)
