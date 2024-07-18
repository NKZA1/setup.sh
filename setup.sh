#!/bin/bash

# Đường dẫn đến thư mục home của Termux
home='/data/data/com.termux/files/'

# Cài đặt và nâng cấp hệ thống
printf '\n\033[1;32m Tiến Hành Cài Dữ Liệu\033[0m\n\n'
termux-setup-storage
apt update
apt upgrade -y

# Cài đặt Python và thư viện requests
printf '\n\033[1;32m Tiến Hành Cài Python\033[0m\n\n'
pkg install python -y
pip install requests



# Tải về script NKZ.py từ GitHub
printf '\n\033[1;32m Tải về script NKZ.py\033[0m\n\n'
curl -s https://raw.githubusercontent.com/NKZA1/NKZ/main/NKZ.py -o $home/usr/bin/nkz
# Thêm quyền thực thi cho script NKZ.py
chmod +x $home/usr/bin/nkz
# Kiểm tra xem tệp đã được tải xuống và có quyền thực thi chưa
if [ -f $home/usr/bin/nkz ]; then
    printf '\n\033[1;32m Script NKZ.py đã được tải xuống và cấp quyền thực thi thành công.\033[0m\n\n'
else
    printf '\n\033[1;31m Không thể tải xuống hoặc cấp quyền thực thi cho script NKZ.py.\033[0m\n\n'
    exit 1
fi

# Hiển thị thông điệp sử dụng
printf '\n\033[1;32m Gõ \033[1;33mnkz \033[1;32mĐể Vào Tool \n\n'

