#!/bin/bash

# ===== CONFIG =====
WALLET="43TgANFiYdJj8544Fm9cjTM5N81FNkfhC21Zv8XL2esPhnEU3hySQaiDwHQKYntCkD8z68KStUGoUWdPde231kJyEWMQuoQ"
POOL="pool.hashvault.pro:3333"
THREADS=$(( $(nproc) - 1 ))  # Giữ lại 1 lõi CPU

# ===== CÀI ĐẶT DEPENDENCIES =====
echo "[*] Cập nhật và cài đặt gói..."
apt update -y
apt install -y git build-essential cmake libuv1-dev libssl-dev

# ===== CLONE VÀ BUILD XMRIG =====
if [ -d "$HOME/xmrig" ]; then
    echo "[*] Xoá xmrig cũ..."
    rm -rf ~/xmrig
fi

echo "[*] Cloning XMRig..."
git clone https://github.com/xmrig/xmrig.git ~/xmrig
cd ~/xmrig
mkdir build && cd build
cmake -DWITH_HWLOC=OFF ..
make -j$(nproc)

# ===== TẠO SCRIPT MINING =====
echo "[*] Tạo script mining..."
cat > ~/mining.sh << EOF
#!/bin/bash
cd ~/xmrig/build
echo "Bắt đầu đào với ${THREADS} luồng CPU"
echo "Đang đào vào ví: ${WALLET:0:12}..."
./xmrig -o $POOL -u $WALLET -p x -t $THREADS --max-cpu-usage=95 --cpu-priority=3 --randomx-1gb-pages --tls --tls-fingerprint=420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14
EOF

chmod +x ~/mining.sh

# ===== TẠO ALIAS TẠM THỜI =====
alias mining="~/mining.sh"

echo -e "\n✅ Cài đặt hoàn tất!"
echo -e "👉 Gõ: mining và nhấn Enter để bắt đầu đào"
echo -e "👉 Nhấn Ctrl+C để dừng"
