#!/bin/bash

# Thiết lập đường dẫn home cho Termux
home='/data/data/com.termux/files/'

printf '\n\033[1;32mTiến Hành Cài Dữ Liệu\033[0m\n\n'
# Hiển thị thông báo tiến hành cài dữ liệu

termux-setup-storage
apt update && apt upgrade -y
pkg update && pkg upgrade -y
pkg install python -y

# Cài đặt các thư viện Python cần thiết
printf '\n\033[1;32mTiến Hành Cài Đặt Các Công Cụ Cần Thiết\033[0m\n\n'
pip install requests
pip install operator

# Tải script nkzz từ GitHub và cài đặt
printf '\n\033[1;32mCài Đặt Script NKZZ\033[0m\n\n'
curl -s https://raw.githubusercontent.com/NKZA1/NKZTOL/main/NKZ.py -o $home/usr/bin/nkzz
chmod 777 $home/usr/bin/nkzz

printf '\n\033[1;32mGõ \033[1;33mnkzz \033[1;32mĐể Vào Tool\n\n'
# Hiển thị thông báo hướng dẫn cách chạy tool
