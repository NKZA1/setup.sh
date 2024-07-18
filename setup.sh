#!/bin/bash

home='/data/data/com.termux/files/'

# Cài đặt và nâng cấp hệ thống
printf '\n\033[1;32m Tiến Hành Cài Dữ Liệu\033[0m\n\n'

# Update and upgrade packages
pkg update
pkg upgrade -y

# Install necessary packages
pkg install clang python python-dev openssl-dev libffi-dev build-essential -y
pkg install libcrypt-dev libffi-dev openssl-dev -y

# Install Python if not installed
pkg install python -y

# Cài đặt các thư viện Python cần thiết
printf '\n\033[1;32m Tiến Hành Cài Python Packages\033[0m\n\n'
pip install --force-reinstall cryptography
pip install requests

# Cấp quyền truy cập cho Termux vào bộ nhớ
termux-setup-storage

# Tải về script NKZ.py từ GitHub và cấp quyền thực thi
printf '\n\033[1;32m Tải về script NKZ.py\033[0m\n\n'
curl -s https://raw.githubusercontent.com/NKZA1/NKZ/main/NKZ.py -o $home/usr/bin/nkz
dos2unix $home/usr/bin/nkz

# Cấp quyền thực thi cho script NKZ.py
chmod +x $home/usr/bin/nkz
if [ -f $home/usr/bin/nkz ]; then
    printf '\n\033[1;32m Script NKZ.py đã được tải xuống và cấp quyền thực thi thành công.\033[0m\n\n'
else
    printf '\n\033[1;31m Không thể tải xuống hoặc cấp quyền thực thi cho script NKZ.py.\033[0m\n\n'
    exit 1
fi

printf '\n\033[1;32m Gõ \033[1;33mnkz \033[1;32mĐể Vào Tool\n\n'
