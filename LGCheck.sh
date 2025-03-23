#!/bin/bash

#task: You need to do a script that automatically checks logs from your system start up and give a feedback every 3 minutes and if everything works normally retrive mds based hash....

#OK...here we go! Bizga I. oxirgi loglarni tekshiradigan > II. keyin undan md5 hash yaratadigan > III. crontab'da har 3 minutda ishga tushadigan > IV. Hashni solishtirib o'zgarsa report beradigan o'zgarmasa feedback beradigan skript kerak.

#Yozib bo'gandan keyin idea keb qoldi): Script har 3minutda ishlashi uchun crontabga qo'yish kerak, unga +x permission berish kerak yana nimadirlar...
#shuni linuxni yaxshi tushnmaydigan lyuboy bir xola ham ishlata oladigan qisamchi?
#takoy seryozniy rasmiy script o'zini tipa "install" qiladigan, ruxsat so'raydigan ...bla bla bla"



conff="/etc/lgcheck.conf"

default_settings() {
    echo "# LGCheck Configuration File" > "$conff"
    echo "LOG_LIMIT=500" >> "$conff"
    echo "NOTIFY_METHOD=console" >> "$conff"
    echo "HASH_FILE=/tmp/lgs_hash.md5" >> "$conff"
}

# Agar config fayli mavjud bo‘lmasa, yaratamiz
if [ ! -f "$conff" ]; then
    echo "[INFO] Config file not found. Creating default config..."
    default_settings
fi

# Configni yuklaymiz
source "$conff"


#
#variables
sname="LGCheck.sh"
inspath="/usr/local/bin/$sname"
hashf="/tmp/lgs_hash.md5"


#BIR CHIMDIM RASMIYATCHILIK:

echo "[INFO] 🚀 Welcome to 'LGCheck by Farzin' Log Monitor Setup!"
echo "[INFO] This script will: "
echo "      ✅ Copy itself to $inspath"
echo "      ✅ Grant execute permissions"
echo "      ✅ Add itself to crontab (runs every X minutes)"
echo "      ✅ Monitor system logs and notify changes"
echo ""
read -p "⚠️ Do you want to continue? (y/n): " choice

if [[ "$choice" != "y" ]]; then
    echo "[EXIT] ❌ Installation cancelled."
    exit 1
fi

#o'zini o'zi copy qilishi (short-circuit bilan. rosti IF ELSE dan to'ydim:) )
echo "[INSTALL] 📂 Copying script to $inspath..."
sudo cp "$0" "$inspath" || { echo "[ERROR] ❌ Failed to copy script. Run with sudo!"; exit 1; }

#Permission beramiz (Script o'ziga o'zi permission beradi 😆 )

echo "[PERMISSION] 🔑 Garanting execute permission "
sudo chmod +x "$inspath" || { echo "[ERROR] ❌ Failed to set permission."; exit 1; }

#har neci sekundda ishga tushirishni nomiga so'rab qo'yamiz)
read -p "⏳ How often should the script run? (minutes, default: 3): " interval
interval=${interval:-3}

farcron="*/$interval * * * * $inspath"

#Crontab'ga qo'shish
if crontab -l 2>/dev/null | grep -q "$inspath"; then
    echo "[INFO] 🔄 Script is already in crontab. Updating interval..."
    crontab -l 2>/dev/null | grep -v "$inspath" | crontab -
fi

echo "[INFO] 📆Scheduling script to run every $interval minutes..."
(crontab -l 2>/dev/null; echo "$farcron") | crontab -

echo -e "[SUCCESS] ✅ Script will run every $interval minutes! \n"

#first of all we need recently logs:
lgs="$(journalctl -n 500)" #Last 100 logs

#Endi hashlash kerak
hash=$(echo "$lgs" | md5sum | sed 's/ .*//')


#Hashni solishtiradigan code kerak:

if [ -f "$hashf" ]
then
    ohash=$(cat "$hashf")

    if [ "$hash" != "$ohash" ]
    then
        echo "[ALERT] ⚠️ System logs have changed. Review recommended."

    else
        echo "[OK]  ✅ No anomalies detected. Everything is operating normally. "
        cat $hashf
    fi
else
    echo "[SYSTEM NOTICE] ℹ️ Previous hash not found. Generating a new one..."
    sleep 3
    echo "[SUCCESS] ✅ Hash created successfully:$hash"

fi

echo "$hash" > "$hashf"
