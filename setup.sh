#!/bin/bash

# Colors for output
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# Display welcome message
printf "\n${GREEN}[NKTOL] | >>welcome<< | created by: Háu Trung Lực${NC}\n\n"

# Function to display error messages
error_exit() {
    printf "${RED}[ERROR] $1${NC}\n"
    exit 1
}

# Function to display status messages
status_msg() {
    printf "${BLUE}[INFO] $1${NC}\n"
}

# Function to display success messages
success_msg() {
    printf "${GREEN}[SUCCESS] $1${NC}\n"
}

# Function to display warnings
warning_msg() {
    printf "${YELLOW}[WARNING] $1${NC}\n"
}

# Check if running in Termux
if [ ! -d "/data/data/com.termux/files" ]; then
    error_exit "This script is designed to run in Termux only."
fi

status_msg "Requesting storage permissions..."
termux-setup-storage

status_msg "Updating packages and installing dependencies..."
apt-get update -y || error_exit "Failed to update packages"
apt-get upgrade -y || warning_msg "Package upgrade failed, but continuing..."

# Install required packages
for pkg in git cmake build-essential; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
        status_msg "Installing $pkg..."
        apt-get install -y $pkg || error_exit "Failed to install $pkg"
    else
        status_msg "$pkg is already installed."
    fi
done

# Clone and build XMRig
status_msg "Cloning and building XMRig..."
cd ~ || error_exit "Cannot change to home directory"

if [ -d "xmrig" ]; then
    status_msg "Removing existing xmrig directory..."
    rm -rf xmrig
fi

git clone https://github.com/xmrig/xmrig.git || error_exit "Failed to clone XMRig repository"
cd xmrig || error_exit "Cannot enter xmrig directory"

mkdir -p build || error_exit "Failed to create build directory"
cd build || error_exit "Cannot enter build directory"

# Build XMRig
status_msg "Building XMRig (this may take a while)..."
cmake .. -DXMRIG_DEPS=scripts/deps -DWITH_HWLOC=OFF || error_exit "CMake configuration failed"
make -j$(nproc) || error_exit "Build failed"

# Verify build was successful
if [ -f xmrig ]; then
    success_msg "XMRig built successfully!"
else
    error_exit "XMRig binary not found after build."
fi

# Configure mining settings
status_msg "Configuring mining settings..."
read -p "Enter your XMR wallet address: " WALLET

if [ -z "$WALLET" ]; then
    warning_msg "No wallet address provided. Using default address."
    WALLET="43TgANFiYdJj8544Fm9cjTM5N81FNkfhC21Zv8XL2esPhnEU3hySQaiDwHQKYntCkD8z68KStUGoUWdPde231kJyEWMQuoQ"
fi

# Create a mining script instead of alias for better control
MINING_SCRIPT="$HOME/xmrig-start.sh"

cat > "$MINING_SCRIPT" << EOF
#!/bin/bash
cd ~/xmrig/build
./xmrig -o pool.hashvault.pro:443 -u $WALLET -p x --tls
EOF

chmod +x "$MINING_SCRIPT"

# Add alias to bashrc
echo "alias xmr='$MINING_SCRIPT'" >> ~/.bashrc

# Source bashrc for current session
source ~/.bashrc

success_msg "Setup completed successfully!"
printf "\n${GREEN}To start mining, simply type: ${YELLOW}xmr${NC}\n"
printf "${GREEN}Your mining configuration:${NC}\n"
printf "${BLUE}Wallet: ${YELLOW}$WALLET${NC}\n"
printf "${BLUE}Pool: ${YELLOW}pool.hashvault.pro:443${NC}\n\n"
warning_msg "Please be aware of the legal and ethical implications of cryptocurrency mining."
warning_msg "Also consider the impact on your device's battery life and hardware lifespan."
