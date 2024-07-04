# Thiết lập đường dẫn home cho Termux
home='/data/data/com.termux/files/'

printf '\n\033[1;32m Tiến Hành Cài Dữ Liệu\033[0m\n\n'
# Hiển thị thông báo tiến hành cài dữ liệu

termux-setup-storage
# Cấp quyền truy cập bộ nhớ cho Termux
apt update

# Cập nhật danh sách gói có sẵn
apt upgrade

# Nâng cấp các gói đã cài đặt lên phiên bản mới nhất

printf '\n\033[1;32m Tiến Hành Cài Đặt Các Công Cụ Cần Thiết\033[0m\n\n'
pkg install python
pip install requests
pip install operator
curl -s https://raw.githubusercontent.com/NKZA1/NKZTOL/main/NKZ.py -o $home/usr/bin/nkzz
# Cài đặt thư viện requests cho Python
chmod 777 $home/usr/bin/nkzz
# Cấp quyền thực thi cho script nkzz

printf '\n\033[1;32m Gõ \033[1;33mnkzz \033[1;32mĐể Vào Tool \n\n'
# Hiển thị thông báo hướng dẫn cách chạy tool
