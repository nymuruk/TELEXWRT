#!/bin/bash

wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW
wget https://github.com/EdyDevz/BW/raw/main/BW && rm BW

# READ AUTH
if [ -f "/root/TgBotWRT/AUTH" ]; then
    TOKEN=$(head -n 1 /root/TgBotWRT/AUTH)
    ID=$(tail -n 1 /root/TgBotWRT/AUTH)
else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

MSG "𝟭𝗚𝗕 𝗧𝗘𝗦𝗧 𝗦𝗨𝗖𝗖𝗘𝗦𝗦𝗙𝗨𝗟✅"

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d "chat_id=$ID" -d "text=$MSG"
exit
