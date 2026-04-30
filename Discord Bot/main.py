import discord
from discord.ext import commands
import logging
from dotenv import load_dotenv
import os
import requests
import api

# Load token
load_dotenv()
token = os.getenv('DISCORD_TOKEN')

# Logging
handler = logging.FileHandler(filename='discord.log', encoding='utf-8', mode='w')

# Intents
intents = discord.Intents.default()
intents.message_content = True
intents.members = True
intents.messages = True

# Bot setup
bot = commands.Bot(command_prefix='!', intents=intents)

API_URL = "http://127.0.0.1:8000"  # your FastAPI server

# ---------------- EVENTS ----------------

@bot.event
async def on_ready():
    print(f"We are ready for lift-off, {bot.user.name}")

# ---------------- COMMANDS ----------------

@bot.command()
async def bosses(ctx):
    """Fetch all bosses from API"""
    try:
        response = requests.get(f"{API_URL}/bosses/")
        response.raise_for_status()
        data = response.json()

        if not data:
            await ctx.send("No bosses found.")
            return

        # format message (Discord has message limits)
        message = "**Boss List:**\n"
        for boss in data[:15]:  # limit to avoid spam
            message += f"- {boss['name']} ({boss['location']})\n"

        await ctx.send(message)

    except requests.exceptions.RequestException as e:
        await ctx.send(f"API error: {e}")

# ---------------- RUN BOT ----------------

bot.run(token, log_handler=handler, log_level=logging.DEBUG)