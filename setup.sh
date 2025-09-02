#!/bin/bash

# ===== CONFIG =====
WALLET="43TgANFiYdJj8544Fm9cjTM5N81FNkfhC21Zv8XL2esPhnEU3hySQaiDwHQKYntCkD8z68KStUGoUWdPde231kJyEWMQuoQ"
POOL="pool.hashvault.pro:3333"
THREADS=$(( $(nproc) - 1 ))  # Leaves one CPU core free

# ===== VERIFICATION PROMPT =====
echo "=============================================="
echo "XMRig Mining Setup Script"
echo "=============================================="
echo "This script will:"
echo "1. Install build dependencies"
echo "2. Compile XMRig from source"
echo "3. Set up mining to wallet: ${WALLET:0:12}..."
echo "4. Use ${THREADS} CPU threads"
echo ""
echo "Starting installation..."


# ===== INSTALL DEPENDENCIES =====
echo "[*] Updating and installing packages..."
apt-get update -y
apt-get install -y git build-essential cmake libuv1-dev libssl-dev

# ===== CLONE AND BUILD XMRIG =====
if [ -d "$HOME/xmrig" ]; then
    echo "[*] Removing old xmrig..."
    rm -rf ~/xmrig
fi

echo "[*] Cloning XMRig..."
git clone https://github.com/xmrig/xmrig.git ~/xmrig
cd ~/xmrig
mkdir build && cd build
cmake -DWITH_HWLOC=OFF ..
make -j$(nproc)

# ===== CREATE MINING SCRIPT =====
echo "[*] Creating mining script..."
cat > ~/mining.sh << EOF
#!/bin/bash
echo "Starting XMRig miner with ${THREADS} threads"
echo "Mining to: ${WALLET:0:12}..."
echo "Press Ctrl+C to stop"
cd ~/xmrig/build
./xmrig -o $POOL -u $WALLET -p x -t $THREADS --max-cpu-usage=95 --cpu-priority=3 --randomx-1gb-pages --tls --tls-fingerprint=420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14
EOF

chmod +x ~/mining.sh

echo -e "\n✅ Setup complete!"
echo -e "👉 To start mining: \033[1;33m~/mining.sh\033[0m"
echo -e "👉 Monitor temperature and system load while mining"
