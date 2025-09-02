#!/bin/bash

# Update & cài package cần thiết
apt-get update -y && apt-get install git -y && pkg install -y cmake build-essential

# Nâng cấp hệ thống
apt update -y && apt upgrade -y

# Clone XMRig
git clone https://github.com/xmrig/xmrig.git && cd xmrig

# Tạo thư mục build
mkdir build && cd build

# Build XMRig (tắt HWLOC để đỡ lỗi trên Android)
cmake -DWITH_HWLOC=OFF .. && make -j$(nproc)

# Hỏi thông tin cấu hình
read -p "Nhập địa chỉ ví XMR: " WALLET
read -p "Nhập Pool (ví dụ: pool.hashvault.pro:443): " POOL
read -p "Nhập số CPU Threads muốn đào (vd: 2): " THREADS

# Tạo script chạy đào
cat > ~/start-xmr.sh << EOF
#!/bin/bash
cd ~/xmrig/build
./xmrig -o $POOL -u $WALLET -p x --tls -t $THREADS
EOF

chmod +x ~/start-xmr.sh

echo "alias xmr='~/start-xmr.sh'" >> ~/.bashrc
source ~/.bashrc

echo -e "\n✅ Cài đặt hoàn tất!"
echo -e "👉 Gõ lệnh: \033[1;33mxmr\033[0m để bắt đầu đào."
