#!/bin/bash

# ===== CONFIG =====
WALLET="43TgANFiYdJj8544Fm9cjTM5N81FNkfhC21Zv8XL2esPhnEU3hySQaiDwHQKYntCkD8z68KStUGoUWdPde231kJyEWMQuoQ"
POOL="pool.hashvault.pro:3333"
THREADS=$(( $(nproc) - 1 ))  # Giữ 1 lõi CPU trống

# ===== CÀI ĐẶT DEPENDENCIES =====
echo "[*] Cập nhật và cài đặt dependencies..."
apt update -y
apt install -y git build-essential cmake libuv1-dev libssl-dev

# ===== XÓA XMRIG CŨ =====
if [ -d "$HOME/xmrig" ]; then
    echo "[*] Xoá XMRig cũ..."
    rm -rf ~/xmrig
fi

# ===== CLONE VÀ BUILD XMRIG =====
echo "[*] Cloning XMRig..."
git clone https://github.com/xmrig/xmrig.git ~/xmrig
cd ~/xmrig
mkdir build && cd build
cmake -DWITH_HWLOC=OFF ..
make -j$(nproc)

# ===== TẠO FILE CONFIG TỰ ĐỘNG =====
echo "[*] Tạo config XMRig..."
cat > ~/xmrig/build/config.json << EOF
{
  "autosave": true,
  "cpu": {
    "enabled": true,
    "threads": $THREADS
  },
  "pools": [
    {
      "url": "$POOL",
      "user": "$WALLET",
      "pass": "x",
      "keepalive": true,
      "tls": true
    }
  ]
}
EOF

# ===== TẠO SCRIPT MINING =====
echo "[*] Tạo lệnh mining..."
cat > ~/mining.sh << EOF
#!/bin/bash
cd ~/xmrig/build
echo "🚀 Bắt đầu đào với $THREADS luồng CPU"
./xmrig
EOF

chmod +x ~/mining.sh

# ===== TẠO ALIAS TẠM THỜI =====
alias mining="~/mining.sh"

echo -e "\n✅ Cài đặt hoàn tất!"
echo -e "👉 Gõ: mining  và nhấn Enter để bắt đầu đào"
echo -e "👉 Nhấn Ctrl+C để dừng đào"
