#!/bin/bash

# Week 4 - Basic Linux System Hardening Script
# GetIntern Cybersecurity Internship

set -e

echo "=========================================="
echo "   Basic Linux System Hardening Script"
echo "=========================================="
echo ""

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "[ERROR] Please run this script with sudo."
    exit 1
fi

echo "[1/4] Updating package information..."
apt update

echo "[OK] Package information updated."
echo ""


# Secure sensitive system files
echo "[2/4] Securing sensitive system files..."

chmod 644 /etc/passwd
chmod 640 /etc/shadow
chmod 644 /etc/group
chmod 640 /etc/gshadow

echo "[OK] Sensitive file permissions secured."
echo ""

# Section 3 — Basic UFW Firewall Setup

echo "[3/4] Configuring UFW firewall..."

# Install UFW if not already installed
apt install -y ufw

# Set secure default policies
ufw default deny incoming
ufw default allow outgoing

# Allow SSH connections
ufw allow 22/tcp

echo "[OK] UFW firewall rules configured."
echo ""

# Section 4 — Basic SSH Security Check

echo "[4/4] Checking SSH configuration..."

if command -v sshd >/dev/null 2>&1; then
    echo "[OK] SSH server is installed."
    sshd -t && echo "[OK] SSH configuration syntax is valid."
else
    echo "[INFO] SSH server is not installed."
fi

echo ""
echo "========================================"
echo " Linux hardening checks completed."
echo "========================================"
