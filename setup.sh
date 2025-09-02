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
cmake -DWITH_HWLOC=OFF .. && make -j$(nproc)

# Tạo script mining
cat > ~/mining << 'EOF'
#!/bin/bash
cd ~/xmrig/build
THREADS=$(( $(nproc) - 1 ))
./xmrig -o asia.hashvault.pro:443 -u 88WgQnTXJNT4iG1x48X6LqcE61B4Ci1ikSaeMYhCYySbVbGsRHHihj7NkLzFdqJcXfnqa4n2fuelu45K2uXPJh -p rx --tls -t $THREADS
EOF

# Cấp quyền chạy
chmod +x ~/mining

# Thêm alias để chỉ cần gõ "mining"
grep -qxF "alias mining='~/mining'" ~/.bashrc || echo "alias mining='~/mining'" >> ~/.bashrc
source ~/.bashrc

echo -e "\n✅ Cài đặt hoàn tất!"
echo -e "👉 Gõ lệnh: \033[1;33mmining\033[0m để bắt đầu đào XMR."
