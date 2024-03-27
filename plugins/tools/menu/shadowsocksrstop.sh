#!/bin/bash

service shadowsocksr stop

# READ AUTH
if [ -f "/root/TELEXWRT/AUTH" ]; then
    IFS=$'\n' read -d '' -r -a lines < "/root/TELEXWRT/AUTH"
    if [ "${#lines[@]}" -ge 2 ]; then
        BOT_TOKEN="${lines[0]}"
        CHAT_ID="${lines[1]}"
    else
        echo "Auth file must have at least 2 lines (your token and chat ID)."
        exit 1
    fi
else
    echo "Auth file not found."
    exit 1
fi

# Create notification message
MSG="Shadowsocksr success to stop!"

# Send notification message to Telegram bot
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MSG"
