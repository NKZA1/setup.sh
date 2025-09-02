#!/bin/bash

# ===== CONFIG =====
WALLET="43TgANFiYdJj8544Fm9cjTM5N81FNkfhC21Zv8XL2esPhnEU3hySQaiDwHQKYntCkD8z68KStUGoUWdPde231kJyEWMQuoQ"
POOL="pool.hashvault.pro:443"
THREADS=$(( $(nproc) - 1 ))

# ===== CÀI ĐẶT GÓI CẦN THIẾT =====
echo "[*] Đang cập nhật và cài đặt package..."
apt-get update -y
apt-get upgrade -y
apt-get install -y git build-essential cmake

# ===== CLONE VÀ BUILD XMRIG =====
if [ -d "$HOME/xmrig" ]; then
    echo "[*] Xóa xmrig cũ..."
    rm -rf ~/xmrig
fi

echo "[*] Clone XMRig..."
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build && cd build
cmake -DWITH_HWLOC=OFF ..
make -j$(nproc)

# ===== TẠO FILE MINING =====
echo "[*] Tạo file mining..."
cat > ~/mining << EOF
#!/bin/bash
cd ~/xmrig/build
./xmrig -o $POOL -u $WALLET -p rx --tls --tlsverify=0
EOF

chmod +x ~/mining

# ===== MOVE VÀO BIN =====
echo "[*] Thêm lệnh mining vào hệ thống..."
mv ~/mining $PREFIX/bin/mining
chmod +x $PREFIX/bin/mining

echo -e "\n✅ Cài đặt hoàn tất!"
echo -e "👉 Chỉ cần gõ: \033[1;33mmining\033[0m để bắt đầu đào 🚀"
