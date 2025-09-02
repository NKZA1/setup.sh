#!/bin/bash

# Update & cài package cần thiết
apt-get update -y && apt-get install git -y && pkg install -y cmake build-essential

# Nâng cấp hệ thống
apt update -y && apt upgrade -y

# Clone XMRig
if [ -d "$HOME/xmrig" ]; then
    rm -rf "$HOME/xmrig"
fi
git clone https://github.com/xmrig/xmrig.git && cd xmrig

# Tạo thư mục build
mkdir -p build && cd build

# Build XMRig (tắt HWLOC để đỡ lỗi trên Android)
cmake -DWITH_HWLOC=OFF .. || { echo "CMake failed"; exit 1; }
make -j$(nproc) || { echo "Build failed"; exit 1; }

# Ví XMR cố định (do bạn cung cấp)
WALLET="43TgANFiYdJj8544Fm9cjTM5N81FNkfhC21Zv8XL2esPhnEU3hySQaiDwHQKYntCkD8z68KStUGoUWdPde231kJyEWMQuoQ"

# Pool mặc định (bạn có thể sửa trực tiếp nếu muốn pool khác)
POOL="pool.hashvault.pro:443"

# Số threads mặc định = số lõi CPU
THREADS=$(nproc)

# Tạo script chạy đào
cat > ~/start-xmr.sh << EOF
#!/bin/bash
cd ~/xmrig/build
./xmrig -o $POOL -u $WALLET -p x --tls -t $THREADS
EOF

chmod +x ~/start-xmr.sh

# Thêm alias 'mining' (không thêm trùng lặp)
grep -qxF "alias mining='~/start-xmr.sh'" ~/.bashrc || echo "alias mining='~/start-xmr.sh'" >> ~/.bashrc
# Source bashrc cho session hiện tại (nếu dùng bash)
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

echo -e "\n✅ Cài đặt hoàn tất!"
echo -e "👉 Gõ lệnh: \033[1;33mmining\033[0m để bắt đầu đào."
echo -e "Ví: $WALLET"
echo -e "Pool: $POOL"
echo -e "Threads: $THREADS"
