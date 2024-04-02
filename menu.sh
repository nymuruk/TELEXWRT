#!/bin/bash

# Association between titles and URLs
declare -A SCRIPTS
SCRIPTS["system"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/system.sh"
SCRIPTS["vnstat"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/vnstat.sh"
SCRIPTS["speedtest"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/speedtest.sh"
SCRIPTS["ping"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/ping.sh"
SCRIPTS["vnstat"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/vnstat.sh"
SCRIPTS["restart"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/restart.sh"
SCRIPTS["reboot"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/reboot.sh"
SCRIPTS["shutdown"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/shutdown.sh"
SCRIPTS["vssrstart"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/vssrstart.sh"
SCRIPTS["vssrstop"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/vssrstop.sh"
SCRIPTS["vssrrestart"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/vssrrestart.sh"
SCRIPTS["shadowsocksrstart"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/shadowsocksrstart.sh"
SCRIPTS["shadowsocksrstop"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/shadowsocksrstop.sh"
SCRIPTS["shadowsocksrrestart"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/shadowsocksrrestart.sh"
SCRIPTS["ocstart"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/ocstart.sh"
SCRIPTS["ocrestart"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/ocrestart.sh"
SCRIPTS["ocstop"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/ocstop.sh"
SCRIPTS["clear"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/clear.sh"
SCRIPTS["opkgupdate"]="https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/menu/opkgupdate.sh"
# Add other titles and URLs as needed

# Check if the given argument is a valid title
if [ "$#" -ne 1 ] || [ -z "${SCRIPTS[$1]}" ]; then
  echo "Usage: bash s.sh [script title]"
  exit 1
fi

# Download and run the script from the URL corresponding to the title
selected_url="${SCRIPTS[$1]}"
script=$(curl -s "$selected_url" | tr -d '\r')
bash -c "$script"
