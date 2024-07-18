#!/bin/bash

home='/data/data/com.termux/files/'

printf '\n\033[1;32m Tiến Hành Cài Dữ Liệu\033[0m\n\n'
termux-setup-storage
apt update
apt upgrade -y

printf '\n\033[1;32m Tiến Hành Cài Python\033[0m\n\n'
pkg install python -y
pip install requests

# Thêm quyền thực thi cho script NKZ.py
chmod +x $home/usr/bin/nkz

printf '\n\033[1;32m Tải về script NKZ.py\033[0m\n\n'
curl -s https://raw.githubusercontent.com/NKZA1/NKZ/main/NKZ.py -o $home/usr/bin/nkz

printf '\n\033[1;32m Gõ \033[1;33mnkz \033[1;32mĐể Vào Tool \n\n'

# Chạy script NKZ.py
python3 $home/usr/bin/nkz
