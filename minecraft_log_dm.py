import json
import contextlib

import discord
from discord.ext import tasks

prev = None
cur = None

client = discord.Client()
config = json.load(open('config.json'))

# TODO: config.users either does not work, or people have bad DM settings
#  -> create account as self-bot which posts into the group?

@tasks.loop(seconds=10)
async def post_new_logs():

    with contextlib.suppress(Exception):

        global prev
        global cur

        prev = cur

        with open('logs/latest.log') as f:
            cur = f.readlines()

        if prev is None or len(prev) == len(cur):
            return

        for line in cur[len(prev):]:
            if 'left the game' in line or 'logged in with' in line:
                line = line[line.find(']: ')+3:]
                if 'logged in with' in line:
                    line = line[:line.find('[/')] + ' joined the game'

                for user_id in config['users']:
                    with contextlib.suppress(Exception):
                        await client.get_user(user_id).send(line)

post_new_logs.start()
client.run(config['DISCORD_BOT_SECRET'])
