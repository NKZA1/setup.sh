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
# Hiển thị thông báo tiến hành cài đặt các công cụ cần thiết

pkg install -y python curl
# Cài đặt Python và curl

pip install requests
# Cài đặt thư viện requests cho Python

# Kiểm tra xem curl có sẵn không
if ! command -v curl &> /dev/null
then
    echo "curl không được cài đặt. Tiến hành cài đặt curl."
    pkg install -y curl
fi

# Tải về script NKZ.py từ GitHub và lưu vào thư mục /usr/bin/ với tên là nkzz
curl -s https://raw.githubusercontent.com/NKZA1/NKZTOL/main/NKZ.py -o $home/usr/bin/nkzz

# Kiểm tra xem tệp NKZ.py đã được tải xuống thành công chưa
if [ -f $home/usr/bin/nkzz ]; then
    echo "Tải xuống và cài đặt thành công tệp NKZ.py."
else
    echo "Lỗi khi tải xuống tệp NKZ.py."
fi

chmod 777 $home/usr/bin/nkzz
# Cấp quyền thực thi cho script nkzz

printf '\n\033[1;32m Gõ \033[1;33mnkzz \033[1;32mĐể Vào Tool \n\n'
# Hiển thị thông báo hướng dẫn cách chạy tool
