#!/bin/bash

# ===== CONFIG =====
WALLET="43TgANFiYdJj8544Fm9cjTM5N81FNkfhC21Zv8XL2esPhnEU3hySQaiDwHQKYntCkD8z68KStUGoUWdPde231kJyEWMQuoQ"
POOL="pool.hashvault.pro:3333"
THREADS=$(( $(nproc) - 1 ))  # Leave one CPU core free

# ===== START INSTALLATION =====
echo "=============================================="
echo "XMRig Mining Setup Script"
echo "=============================================="
echo "Installing dependencies, building XMRig..."
echo "Mining to wallet: ${WALLET:0:12}..."
echo "Using $THREADS CPU threads"
echo ""

# ===== INSTALL DEPENDENCIES =====
apt update -y
apt install -y git build-essential cmake libuv1-dev libssl-dev

# ===== REMOVE OLD XMRIG =====
if [ -d "$HOME/xmrig" ]; then
    echo "[*] Removing old xmrig..."
    rm -rf ~/xmrig
fi

# ===== CLONE XMRIG =====
echo "[*] Cloning XMRig..."
git clone https://github.com/xmrig/xmrig.git ~/xmrig

# ===== BUILD XMRIG =====
cd ~/xmrig
mkdir build && cd build
cmake -DWITH_HWLOC=OFF ..
make -j$(nproc)

# ===== CREATE MINING SCRIPT =====
echo "[*] Creating mining script..."
cat > ~/mining.sh << EOF
#!/bin/bash
cd ~/xmrig/build
echo "Starting XMRig miner with ${THREADS} threads"
echo "Mining to: ${WALLET:0:12}..."
./xmrig -o $POOL -u $WALLET -p x -t $THREADS --max-cpu-usage=95 --cpu-priority=3 --randomx-1gb-pages
EOF

chmod +x ~/mining.sh

# ===== CREATE TEMPORARY ALIAS =====
alias mining="~/mining.sh"

echo -e "\n✅ Setup complete!"
echo -e "👉 Now type: mining  and press Enter to start mining"
echo -e "👉 Press Ctrl+C to stop mining"
