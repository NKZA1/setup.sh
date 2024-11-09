#!/bin/bash

# Hiển thị thông điệp chào mừng
printf '\n\033[1;32m [NKTOL] | >>welcome<< | create by: Háu Trung Lực\033[0m\n\n'

# Đường dẫn đến thư mục chính của Termux
home='/data/data/com.termux/files/'

# Cài đặt và nâng cấp hệ thống
printf '\n\033[1;32m Tiến Hành Cài Dữ Liệu\033[0m\n\n'

# Cập nhật và nâng cấp các gói
termux-setup-storage
apt update && apt upgrade -y

# Cài đặt Python
pkg install python -y

# Cài đặt các thư viện Python cần thiết
printf '\n\033[1;32m Tiến Hành Cài Python Packages\033[0m\n\n'
pip install --upgrade pip  # Cập nhật pip
pip install requests cloudscraper
pip install cloudscraper
# Tải về script NKZ.py từ GitHub
printf '\n\033[1;32m Tải về script NKZ.py\033[0m\n\n'
curl -s https://raw.githubusercontent.com/NKZA1/NKZTOL/refs/heads/main/NKZ.py -o $home/usr/bin/nkz

# Chuyển đổi file về định dạng Unix
dos2unix $home/usr/bin/nkz

# Cấp quyền thực thi cho script NKZ.py
chmod +x $home/usr/bin/nkz

# Kiểm tra xem file đã được tải về và cấp quyền thực thi thành công chưa
if [ -f $home/usr/bin/nkz ]; then
    printf '\n\033[1;32m Script NKZ.py đã được tải xuống và cấp quyền thực thi thành công.\033[0m\n\n'
else
    printf '\n\033[1;31m Không thể tải xuống hoặc cấp quyền thực thi cho script NKZ.py.\033[0m\n\n'
    exit 1
fi

printf '\n\033[1;32m Gõ \033[1;33mnkz \033[1;32m để vào tool\n\n'
