#!/usr/bin/env bash
set -e

echo "[1/4] Installing dependencies..."
sudo apt update
sudo apt install -y fprintd libpam-fprintd

echo "[2/4] Installing patched libfprint..."
sudo dpkg -i libfprint-2-2_*.deb libfprint-dev_*.deb

echo "[3/4] Fixing library path..."
sudo ldconfig

echo "[4/4] Restarting service..."
sudo systemctl restart fprintd

echo "--------------------------------"
echo "Done!"
echo "Run:"
echo "  fprintd-enroll"
echo "  fprintd-verify"
