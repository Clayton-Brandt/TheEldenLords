import discord
from discord.ext import commands
import logging
from dotenv import load_dotenv
import os
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
    try:
        data = api.get_all_bosses()

        if not data:
            await ctx.send("No bosses found.")
            return

        message = "**Boss List:**\n"
        for boss in data[:15]:
            name = boss.get("name", "Unknown")
            location = boss.get("location", "Unknown")
            message += f"- {name} ({location})\n"

        await ctx.send(message)

    except Exception as e:
        await ctx.send(f"API error: {e}")


@bot.command()
async def boss(ctx, boss_id: int):
    try:
        data = api.get_boss(boss_id)

        name = data.get("name", "Unknown")
        location = data.get("location", "Unknown")

        await ctx.send(f"**{name}** is located at {location}")

    except Exception:
        await ctx.send("Boss not found.")


@bot.command()
async def searchboss(ctx, *, name):
    try:
        data = api.search_boss(name)

        if not data:
            await ctx.send("No bosses found.")
            return

        message = "**Search Results:**\n"
        for boss in data[:10]:  # limit results
            boss_name = boss.get("name", "Unknown")
            location = boss.get("location", "Unknown")
            message += f"- {boss_name} ({location})\n"

        await ctx.send(message)

    except Exception as e:
        await ctx.send(f"API error: {e}")


@bot.command()
async def addboss(ctx, name, *, location):
    try:
        api.create_boss(name, location)
        await ctx.send(f"Boss '{name}' created at {location}.")

    except Exception as e:
        await ctx.send(f"Failed to create boss: {e}")


@bot.command()
async def deleteboss(ctx, boss_id: int):
    try:
        api.delete_boss(boss_id)
        await ctx.send(f"Boss with ID {boss_id} deleted.")

    except Exception as e:
        await ctx.send(f"Failed to delete boss: {e}")


@bot.command()
async def updateboss(ctx, boss_id: int, name, *, location):
    try:
        api.update_boss(boss_id, name, location)
        await ctx.send(f"Boss {boss_id} updated to '{name}' at {location}.")

    except Exception as e:
        await ctx.send(f"Failed to update boss: {e}")


@bot.command()
async def lore(ctx, boss_id: int):
    try:
        data = api.get_boss_lore(boss_id)

        if not data:
            await ctx.send("No lore found.")
            return

        message = f"**Lore for Boss {boss_id}:**\n"
        for line in data:
            message += f"- {line}\n"

        await ctx.send(message)

    except Exception:
        await ctx.send("No lore found for this boss.")


@bot.command()
async def prereq(ctx, boss_id: int):
    try:
        data = api.get_boss_prerequisites(boss_id)

        if not data:
            await ctx.send("No prerequisites found.")
            return

        message = f"**Prerequisites for Boss {boss_id}:**\n"
        for item in data:
            message += f"- {item}\n"

        await ctx.send(message)

    except Exception:
        await ctx.send("No prerequisites found for this boss.")


@bot.command()
async def stats(ctx, boss_id: int):
    try:
        data = api.get_boss_stats(boss_id)

        embed = discord.Embed(
            title=f"Boss {boss_id} Stats",
            color=discord.Color.blue()
        )

        # loop through all fields except boss_id
        for key, value in data.items():
            if key != "boss_id":
                embed.add_field(name=key.capitalize(), value=value, inline=True)

        await ctx.send(embed=embed)

    except Exception:
        await ctx.send("No stats found for this boss.")


@bot.command()
async def resist(ctx, boss_id: int):
    try:
        data = api.get_boss_resistances(boss_id)

        if not data:
            await ctx.send("No resistances found.")
            return

        message = f"**Resistances for Boss {boss_id}:**\n"
        for r in data:
            message += f"- {r}\n"

        await ctx.send(message)

    except Exception:
        await ctx.send("No resistances found for this boss.")


@bot.command()
async def weak(ctx, boss_id: int):
    try:
        data = api.get_boss_weaknesses(boss_id)

        if not data:
            await ctx.send("No weaknesses found.")
            return

        message = f"**Weaknesses for Boss {boss_id}:**\n"
        for w in data:
            message += f"- {w}\n"

        await ctx.send(message)

    except Exception:
        await ctx.send("No weaknesses found for this boss.")


@bot.command()
async def rewards(ctx, boss_id: int):
    try:
        data = api.get_boss_rewards(boss_id)

        if not data:
            await ctx.send("No rewards found.")
            return

        message = f"**Rewards for Boss {boss_id}:**\n"
        for r in data:
            message += f"- {r}\n"

        await ctx.send(message)

    except Exception:
        await ctx.send("No rewards found for this boss.")


@bot.command()
async def helpboss(ctx, boss_id: int):
    try:
        data = api.get_boss_help_links(boss_id)

        if not data:
            await ctx.send("No help links found.")
            return

        embed = discord.Embed(
            title=f"Help Links for Boss {boss_id}",
            color=discord.Color.green()
        )

        for link in data:
            title = link.get("title", "Untitled")
            url = link.get("url", "")

            embed.add_field(
                name=title,
                value=url,
                inline=False
            )

        await ctx.send(embed=embed)

    except Exception:
        await ctx.send("No help links found for this boss.")




# ---------------- RUN BOT ----------------

bot.run(token, log_handler=handler, log_level=logging.DEBUG)