#!/bin/bash

# noctalia-sddm-sync installer
# Automates the creation of dummy files and permissions for Noctalia and Silent SDDM.

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

SDDM_DIR="/usr/share/sddm/themes/silent"
BG_IMG="$SDDM_DIR/backgrounds/current_noctalia.jpg"
CONFIG_SRC="$SDDM_DIR/configs/default.conf"
CONFIG_DEST="$SDDM_DIR/configs/noctalia.conf"

echo -e "${BLUE}Setting up Noctalia + Silent SDDM Sync...${NC}"

# 1. Create a dummy image and assign ownership to the current user
echo "Creating dummy background image..."
sudo touch "$BG_IMG"
sudo chown $USER:$USER "$BG_IMG"
chmod 644 "$BG_IMG"

# 2. Create the Noctalia specific configuration profile
echo "Creating noctalia.conf profile..."
sudo cp "$CONFIG_SRC" "$CONFIG_DEST"

# 3. Update the background path in the new profile
echo "Patching background path..."
sudo sed -i 's|^background = .*|background = "current_noctalia.jpg"|' "$CONFIG_DEST"

echo -e "${GREEN}System setup completed!${NC}"
echo "Next step: Please follow the README instructions to configure Silent SDDM and Noctalia hooks."
