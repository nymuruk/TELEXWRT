#!/bin/sh

# Get the package name from the first argument
NAME="$1"

# READ AUTH
if [ -f "/root/TELEXWRT/AUTH" ]; then
    IFS=$'\n' read -d '' -r -a lines < "/root/TELEXWRT/AUTH"
    if [ "${#lines[@]}" -ge 2 ]; then
        BOT_TOKEN="${lines[0]}"
        CHAT_ID="${lines[1]}"
    else
        echo "Berkas auth harus memiliki setidaknya 2 baris (token dan chat ID Anda)."
        exit 1
    fi
else
    echo "Berkas auth tidak ditemukan."
    exit 1
fi

# Function to send a message to the Telegram bot
send_telegram_message() {
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$1" \
        -d "parse_mode=Markdown"
}

# Install the package using opkg
OUTPUT=$(/bin/opkg install $NAME)

# Check the exit status of the opkg command
if [ $? == 255 ]; then
  # Print an error message and the output of opkg
  echo "error installing package $NAME!"
  echo $OUTPUT

  # Send a notification to Telegram bot with the error message
  MSG="$NAME successfully not installed!"
  send_telegram_message "$MSG"
else
  # Print a success message and the output of opkg
  echo "install package done!"
  echo $OUTPUT

  # Send a notification to Telegram bot with the success message
  MSG="$NAME successfully installed!"
  send_telegram_message "$MSG"
fi
