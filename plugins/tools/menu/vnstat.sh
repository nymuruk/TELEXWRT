#!/bin/bash

# READ AUTH
if [ -f "/root/TELEXWRT/AUTH" ]; then
    IFS=$'\n' read -d '' -r -a lines < "/root/TELEXWRT/AUTH"
    if [ "${#lines[@]}" -ge 2 ]; then
        BOT_TOKEN="${lines[0]}"
        CHAT_ID="${lines[1]}"
    else
    echo "Berkas AUTH tidak ditemukan."
    exit 1
fi

# Fungsi untuk mengambil data download, upload, dan total dari vnstat
get_daily_bandwidth() {
    vnstat_output=$(vnstat -i br-lan -d 1 --style 0 | sed -n 6p)
    download=$(echo "$vnstat_output" | awk '{print $5, $6}')
    upload=$(echo "$vnstat_output" | awk '{print $2, $3}')
    total=$(echo "$vnstat_output" | awk '{print $8, $9}')
    
    echo "
➤ 𝗕𝗔𝗡𝗗𝗪𝗜𝗗𝗧𝗛 𝗗𝗔𝗜𝗟𝗬 𝗥𝗘𝗣𝗢𝗥𝗧 📊

📥 𝗗𝗢𝗪𝗡𝗟𝗢𝗔𝗗: $download
📤 𝗨𝗣𝗟𝗢𝗔𝗗: $upload
📊 𝗧𝗢𝗧𝗔𝗟: $total
⏰ 𝗟𝗔𝗦𝗧 𝗨𝗣𝗗𝗔𝗧𝗘: $(date +'%d-%m-%Y %I:%M %p')

➤ 𝘾𝙝𝙚𝙘𝙠𝙚𝙙 𝙗𝙮 𝙀𝙙𝙮 𝘿𝙚𝙫𝙚𝙡𝙤𝙥𝙚𝙧 🤖
"
}

# Main program
get_ip_info
MSG=$(get_daily_bandwidth)

# Mengirim pesan ke akun Telegram pribadi
curl -F "chat_id=$CHAT_ID" -F "caption=$MSG" -F "photo=$URL" \
https://api.telegram.org/bot$BOT_TOKEN/sendphoto
