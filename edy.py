import telepot
import subprocess
import time
import threading
import os
import requests
import hashlib
import datetime
import random

# Read token and admin ID from token.txt
with open('/root/TELEXWRT/AUTH', 'r') as token_file:
    lines = token_file.readlines()
    if len(lines) >= 2:
        TOKEN = lines[0].strip()
        USER_ID = int(lines[1].strip())
    else:
        print("Token file must have at least 2 lines (token and admin chat ID).")
        exit()

# List of admin chat IDs
admins = set([USER_ID])

# Stop file path (semaphore)
STOP_FILE_PATH = '/root/TELEXWRT/stop_bot.txt'

# Command file path
CMD_FILE_PATH = '/root/TELEXWRT/cmd'

# URL to fetch menu from url/raw
MENU_RAW_URL = 'https://raw.githubusercontent.com/nymurbd/TELEXWRT/main/plugins/tools/menu/menu'  # Replace with your desired url/raw URL

# Interval to check for cmd changes (in seconds)
RELOAD_INTERVAL = 600  # This will check every 10 minutes

# Current cmd file hash
current_cmd_file_hash = None

# Global variable for bot start time
bot_start_time = None

# List of stickers for incorrect command responses
sticker_list = [
   "CAACAgQAAxkBAAECMWNlu3bhZETf08EZKaC6mNV3jRL3_AAC0gsAAhb0sVHnZdkv2V_TgzQE",
"CAACAgQAAxkBAAECMWdlu3bl1XLhl098fpNAPws459muHgACmBAAAneDeVN5LZnXk3f79DQE",
"CAACAgQAAxkBAAECMWtlu3bo-2xYZjxynMB2g2CPgXgBKgACqgoAAnZr4FMPUGZeiWkAAcQ0BA",
"CAACAgQAAxkBAAECMW9lu3bx2BDQbzLCCJ0HDoWlvuQbrwACTAsAAv5ZsFF2q1VvBT3vvzQE",
"CAACAgQAAxkBAAECMXNlu3gDgU9A7rzNiZHHyuSCkkGoiAACBQwAAj8y8FFu9A81FIT5TzQE",
"CAACAgQAAxkBAAECMXdlu3gVaQVcIrStAsE7J8KV4RBWlwAC0AsAAmCiMFCyj6GosflqdTQE",
"CAACAgEAAxkBAAECMXtlu3jybCLsU6twJ83LRytWCniGJQACqgMAAlEpDTnfi2Gpd_RM2DQE",
"CAACAgEAAxkBAAECMX9lu3kCdw4uCRTwugEirsyw75u4qwACTAIAAlEpDTmW-Nn5uUz4NDQE",
"CAACAgQAAxkBAAECMYdlu3k6M2JxPFcnGMI2JxaS0o1QhQACqhEAAvLjMFOVLZ-ZSUQkBzQE",
"CAACAgQAAxkBAAECMYtlu3lARqJsNvc6QN2oCN-r2qO8GQACyQkAAv0J6VBpFSz2Lfm2-jQE",
"CAACAgQAAxkBAAECMY9lu3lFgOoo-wmL0WWaMgQ0GlCWUAACnBIAAqbxcR6Xl8vipkImWDQE",
"CAACAgQAAxkBAAECMZNlu3oOWycqPGDSm8y38w-Ev8wAAZQAAt0IAAKOfCFQwPyGuUwYDqo0BA",
]

# Set to track sent stickers
sent_stickers = set()

# Function to execute commands in terminal without displaying output
def run_command(command):
    try:
        subprocess.run(command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    except subprocess.CalledProcessError as e:
        return False

# Function to read alias text file
def load_aliases(file_path):
    aliases = {}
    try:
        with open(file_path, 'r') as file:
            for line in file:
                parts = line.strip().split(':')
                if len(parts) == 2:
                    alias, cmd = parts
                    aliases[alias.strip()] = cmd.strip()
    except Exception as e:
        print(f"Error loading aliases: {str(e)}")
    return aliases

# Function to delete message after a certain time
def delete_message_after(USER_ID, message_id, seconds):
    time.sleep(seconds)
    bot.deleteMessage((USER_ID, message_id))

# Function to send menu message from URL
def send_menu_from_url(USER_ID):
    try:
        response = requests.get(MENU_RAW_URL)
        if response.status_code == 200:
            menu_text = response.text
            bot.sendMessage(USER_ID, menu_text, parse_mode="Markdown")
        else:
            bot.sendMessage(USER_ID, "Failed to fetch menu from URL.")
    except Exception as e:
        print(f"Error sending menu from URL: {str(e)}")

# Function to send a random sticker if command is incorrect
def send_random_sticker(USER_ID):
    while True:
        sticker_to_send = random.choice(sticker_list)
        if sticker_to_send not in sent_stickers:
            sent_stickers.add(sticker_to_send)
            break
    bot.sendSticker(USER_ID, sticker_to_send)

# Function to handle /menu command
def handle_start(msg):
    USER_ID = msg['chat']['id']
    send_menu_from_url(USER_ID)

# Function to handle messages received from Telegram bot
def handle(msg):
    USER_ID = msg['chat']['id']
    user_id = msg['from']['id']
    
    if 'text' in msg:
        command = msg['text']
        
        if command == '/menu':
            handle_start(msg)
        elif user_id in admins:
            if command.startswith('/cmd'):
                parts = command.split(' ', 1)
                if len(parts) == 2:
                    cmd_to_run = parts[1]
                    wait_message = bot.sendMessage(USER_ID, "Please wait...")
                    if run_command(cmd_to_run):
                        bot.deleteMessage((USER_ID, wait_message['message_id']))
                    else:
                        send_random_sticker(USER_ID)
                        bot.sendMessage(USER_ID, "Command is incorrect or failed to execute.")
                        t = threading.Thread(target=delete_message_after, args=(USER_ID, msg['message_id'], 5))
                        t.start()
                else:
                    send_random_sticker(USER_ID)
                    bot.sendMessage(USER_ID, "The /cmd command format is incorrect. Use: /cmd <command>")
            else:
                if command in aliases:
                    wait_message = bot.sendMessage(USER_ID, "Please wait...")
                    if run_command(aliases[command]):
                        bot.deleteMessage((USER_ID, wait_message['message_id']))
                    else:
                        send_random_sticker(USER_ID)
                        bot.sendMessage(USER_ID, "Wrong Command, Use /menu To Check")
                        t = threading.Thread(target=delete_message_after, args=(USER_ID, msg['message_id'], 5))
                        t.start()
                else:
                    send_random_sticker(USER_ID)
                    bot.sendMessage(USER_ID, "Wrong Command, Use /menu To Check")
        else:
            send_random_sticker(USER_ID)
            bot.sendMessage(USER_ID, "You are not authorized.")
    else:
        send_random_sticker(USER_ID)
        bot.sendMessage(USER_ID, "Wrong Command, Use /menu To Check")

# Function to check internet connection
def check_internet_connection():
    try:
        response = requests.get('https://www.google.com', timeout=10)
        return True
    except (requests.ConnectionError, requests.Timeout):
        return False

# Function to reload cmd file if changed
def reload_cmd_file():
    global current_cmd_file_hash
    new_cmd_file_hash = get_file_md5_hash(CMD_FILE_PATH)
    if new_cmd_file_hash != current_cmd_file_hash:
        current_cmd_file_hash = new_cmd_file_hash
        aliases = load_aliases(CMD_FILE_PATH)

# Function to calculate MD5 hash of a file
def get_file_md5_hash(file_path):
    hash_md5 = hashlib.md5()
    with open(file_path, "rb") as file:
        for chunk in iter(lambda: file.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

# Initialize Telegram bot
bot = telepot.Bot(TOKEN)
bot.message_loop(handle)

# Get list of aliases from text file
aliases = load_aliases(CMD_FILE_PATH)
current_cmd_file_hash = get_file_md5_hash(CMD_FILE_PATH)

# Set bot start time
bot_start_time = datetime.datetime.now()

print('Bot is running. To stop, use the /stopbot command.')

# Let the bot run continuously until stop file is present
while not os.path.exists(STOP_FILE_PATH):
    try:
        if check_internet_connection():
            pass
        else:
            print('No internet connection. Waiting...')
            time.sleep(60)
        if time.time() % RELOAD_INTERVAL == 0:
            reload_cmd_file()
    except Exception as e:
        print(f"Error occurred: {str(e)}")
        time.sleep(60)

print('Bot stopped.')


