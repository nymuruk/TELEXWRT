#!/bin/bash

cd
opkg install git
opkg install git-http
opkg install python3
opkg install python3-pip
opkg install jq
opkg install sysstat
pip3 install telepot requests python-telegram-bot
opkg list-installed | grep python3
pip3 list
git clone -b For-Bangladesh https://github.com/nymurbd/TELEXWRT
mv /root/TELEXWRT/edy /etc/init.d/
mv /root/TELEXWRT/edy.py /usr/bin/
chmod +x /etc/init.d/edy
chmod +x /usr/bin/edy.py
chmod +x /root/TgBotWRT/*
rm -rf /root/TELEXWRT/plugins
clear
echo "Please input your id & bot token => nano /root/TELEXWRT/AUTH"
sleep 2
clear
echo "Please type 'service edy enable' to enable the service, and then type 'service edy start"
