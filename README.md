### TELEGRAM BOT FOR OPENWRT [**FOR GOLOBAL REPO**](URL)

* [**OWNER DEV**](https://t.me/EdyDevz)
* [**DECODE (RICK)**](https://t.me/rickk1kch)
* [**MODIFIED (NYMUR)**](https://github.com/nymurbd)
* [**SPECIAL THANKS (LiKH0N)**](https://github.com/LiKH0N)
##### INDONESIAN VIDEO TUTORIAL
* [**VIEW ON YOUTUBE**](https://youtu.be/4zhOv0Ke_Vs?si=B2qRDOyYifILzSur)

### NOTE ❗
***THE TUTORIAL IS COMPLETE ALREADY! NO NEED TO ASK TOO MANY QUESTIONS! READ IT ALL TO UNDERSTAND!!!***

### REQUIREMENTS

* `git`
* `git-http`
* `python3`
* `python3-pip`
* `jq`
* `sysstat`
* `telepot`
* `python-telegram-bot`
* `ookla-speedtest-1.1.1`



##### MANUAL INSTALLATION 😎

```
opkg update
```

```
opkg install git
```

```
opkg install git-http
```

```
opkg install python3
```

```
opkg install python3-pip
```

```
opkg install jq
```

```
opkg install sysstat
```

```
pip3 install telepot requests python-telegram-bot
```

```
opkg list-installed | grep python3 && pip3 list
```
##### CLONE REPO

```
git clone -b For-Bangladesh https://github.com/nymurbd/TELEXWRT
```
##### MOVE ALL PACKAGE

```
mv /root/TELEXWRT/edy /etc/init.d/ && mv /root/TELEXWRT/edy.py /usr/bin/ && chmod +x /usr/bin/edy.py && chmod +x /etc/init.d/edy && rm -rf /root/TELEXWRT/plugins
```

##### AUTO INSTALLER 🚀

```
opkg update && (cd /tmp && curl -sLko install https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/installer.sh && bash install)
```

##### EDIT AUTH ADMIN & BOT
```
nano /root/TELEXWRT/AUTH
```

##### SCHEDULED TASKS
**COPY TO** `SCHEDULED TASK`
```
*/30 * * * * service edy restart
```


##### ENABLE SERVICE ✅

```
service edy enable
```

##### START BOT 🚀

```
service edy start
```

##### RESTART BOT ♻️

```
service edy restart
```

##### STOP BOT ❌

```
service edy stop
```

#### BOT COMMANDS LIST 

```
system - View System Information  
speedtest - Internet Speed Analysis  
opkgupdate - Opkg Update  
ping - Ping Server  
clear - Clear Memory Usage  
restart - Restart BOT  
reboot - Reboot Server  
shutdown - Shutdown Server  
bdixstart - Start Bdix  
bdixrestart - Restart Bdix
bdixstop - Stop Bdix
shadowsocksrstart - START SSRP  
shadowsocksrstop - STOP SSRP  
shadowsocksrrestart - RESTART SSRP
```

##### UNINSTALLER BOT 🗑️

```
opkg update && (cd /tmp && curl -sLko install https://raw.githubusercontent.com/nymurbd/TELEXWRT/For-Bangladesh/plugins/tools/uninstaller.sh && bash install)
```


## Commands

**Use** `/menu` **For check CMD 📖**

 * **CMD LIST:**
 * `/system` ***- View System Information 🖥️***
 * `/speedtest` ***- Internet Speed Analysis ⚡***
 * `/vnstat` ***- Vnstat Monitor 🚀***
 * `/ping` ***- Ping Server ⚙️***
 * `/clear` ***- Cache Memory Purge 🗑️***
 * `/restart` ***- Restart BOT 🤖***
 * `/reboot` ***- Reboot STB ♻️***
 * `/shutdown` ***- Shutdown Server 📴***
 * `/dixstart` ***- Start BDIX 🟢***
 * `/bdixrestart` ***- Restart BDIX 🟡***
 * `/bdixstop` ***- Stop BDIX 🔴***

## CREDITS

* **RICKK** [*REPO*](https://github.com/ahmadqsyaa/TELEXWRT) 👉 This repo is a modification of RICKK's repo.

* **EDY DEVELOPER** Main Owner [*REPO*](https://github.com/EdyDevz/TgBotWRT)


### READ THIS ❗

***This repo is based on the work of ***[Mr. Rickk](https://github.com/ahmadqsyaa)*** and ***[Mr. Edy Developer](https://github.com/EdyDevz)***. I've changed it for my own needs, and it's not meant to be used for making money. Please don't use it for anything business-related.  If this repo isn't helpful for you, that's okay –  it's not my fault.***
