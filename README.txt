LGCheck by Farzin 🚀

LGCheck — bu avtomatik log monitoring skripti bo‘lib, u har 3 daqiqada (yoki siz belgilagan vaqtda) tizim loglarini tekshiradi va o‘zgarishlarni kuzatib boradi. Agar loglarda o‘zgarish bo‘lsa, xabar beradi, aks holda hammasi joyida deb tasdiqlaydi.
🔥 O‘rnatish va Ishga Tushirish

1️⃣ Skriptni yuklab oling yoki nusxalab oling:

git clone https://github.com/farzin/lgcheck.git
cd lgcheck

yoki

wget https://raw.githubusercontent.com/farzin/lgcheck/main/LGCheck.sh

2️⃣ Birinchi marta ishga tushirish:

bash LGCheck.sh

(yodingizda bo‘lsin: agar .sh faylni bevosita ishga tushirmoqchi bo‘lsangiz, chmod +x LGCheck.sh qilish kerak)

3️⃣ Skriptni crontab'ga o‘rnatish (avtomatik ravishda ishlaydi)
Skript o‘rnatish jarayonida sizdan necha daqiqada ishga tushishini so‘raydi. Default – 3 daqiqa.

4️⃣ Qo‘lda ishga tushirish:
Agar real vaqtda ishga tushirishni istasangiz, mana bu komandani kiriting:

/usr/local/bin/LGCheck.sh

⚙️ Sozlamalar

Skript sozlamalari /usr/local/bin/LGCheck.sh faylida saqlanadi. Agar interval yoki boshqa parametrlarni o‘zgartirmoqchi bo‘lsangiz, ushbu faylni tahrirlashingiz mumkin.

    Ishlash intervali: Har necha daqiqada tekshirishi kerakligini sozlash mumkin.

    Loglar soni: Nechta oxirgi logni tekshirishi mumkin. Default: 500.

    Hash tekshirish: Loglarni md5 orqali taqqoslash va o‘zgarish bo‘lsa, bildirish berish.

🛠 Muammolar va Yechimlar

1. Skript crontab'ga qo‘shilmadi yoki ishlamayapti?

    crontab -l buyrug‘ini kiriting va ichida LGCheck.sh borligini tekshiring.

    Agar yo‘q bo‘lsa, qo‘lda qo‘shing:

crontab -e

va quyidagi qatordan birini qo‘shing:

    */3 * * * * /usr/local/bin/LGCheck.sh

2. Skript permission error bermoqda?

    Quyidagi buyrug‘ni bajaring:

    sudo chmod +x /usr/local/bin/LGCheck.sh

3. Log o‘zgarishlarini tekshirish ishlamayapti?

    journalctl -n 500 buyrug‘ini qo‘lda bajaring va loglarni ko‘ring.

    cat /tmp/lgs_hash.md5 orqali eski hashni ko‘rib, u bilan yangi loglarni solishtiring.

🏆 Muallif

👤 Farzin
📅 2025

LGCheck – bu tizimingizni kuzatib borish uchun eng yengil va samarali usul! 🚀
