# Week 4 — Linux System Hardening

## 📌 Overview

This project demonstrates basic Linux system hardening using a Bash script on Ubuntu running inside WSL2.

The script performs package updates, secures sensitive file permissions, configures the UFW firewall, and checks SSH configuration.

## 🛠️ Tools Used

```text
Ubuntu Linux
WSL2
Bash
UFW Firewall
OpenSSH
Git & GitHub
```

## 📁 Project Structure

```text
week-4-linux-hardening/
│
├── harden.sh
├── README.md
└── screenshots/
    ├── Screenshot-01.png
    ├── Screenshot-02.png
    ├── Screenshot-03.png
    └── Screenshot-04.png
```

---

# 🔐 Linux Hardening Script

## 1. Root Privilege Check

The script first checks whether it is running with root privileges.

```bash
if [ "$EUID" -ne 0 ]; then
    echo "[ERROR] Please run this script with sudo."
    exit 1
fi
```

Run the script using:

```bash
sudo ./harden.sh
```

---

## 2. Update Package Information

The system package information is updated before performing the hardening tasks.

```bash
echo "[1/4] Updating package information..."
apt update

echo "[OK] Package information updated."
```

---

## 3. Secure Sensitive File Permissions

Sensitive system files should not be writable by normal users.

Example:

```bash
chmod 644 /etc/passwd
chmod 640 /etc/shadow
chmod 644 /etc/group
chmod 640 /etc/gshadow
```

These permissions help prevent unauthorized modification of important authentication and account files.

---

# 🧱 4. UFW Firewall Configuration

## Install UFW

```bash
apt install -y ufw
```

## Set Secure Default Policies

Block incoming connections by default:

```bash
ufw default deny incoming
```

Allow outgoing connections:

```bash
ufw default allow outgoing
```

## Allow SSH

SSH uses TCP port 22:

```bash
ufw allow 22/tcp
```

## Enable Firewall

```bash
ufw enable
```

## Check Firewall Status

```bash
ufw status verbose
```

Expected result:

```text
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere
22/tcp (v6)                ALLOW IN    Anywhere (v6)
```

---

# 🔑 5. SSH Configuration Check

The script checks whether the SSH server is installed.

```bash
if command -v sshd >/dev/null 2>&1; then
    echo "[OK] SSH server is installed."
    sshd -t && echo "[OK] SSH configuration syntax is valid."
else
    echo "[INFO] SSH server is not installed."
fi
```

In this WSL2 environment, the result was:

```text
[4/4] Checking SSH configuration...
[INFO] SSH server is not installed.
```

---

# 📜 Complete Script

```bash
#!/bin/bash

# Week 4 - Basic Linux System Hardening Script
# GetIntern Cybersecurity Internship

set -e

echo "=========================================="
echo "    Basic Linux System Hardening Script"
echo "=========================================="
echo ""

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "[ERROR] Please run this script with sudo."
    exit 1
fi

# Section 1 - Update package information
echo "[1/4] Updating package information..."

apt update

echo "[OK] Package information updated."
echo ""

# Section 2 - Secure sensitive file permissions
echo "[2/4] Securing sensitive system files..."

chmod 644 /etc/passwd
chmod 640 /etc/shadow
chmod 644 /etc/group
chmod 640 /etc/gshadow

echo "[OK] Sensitive file permissions secured."
echo ""

# Section 3 - Configure UFW firewall
echo "[3/4] Configuring UFW firewall..."

apt install -y ufw

ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp

echo "[OK] UFW firewall rules configured."
echo ""

# Section 4 - Basic SSH security check
echo "[4/4] Checking SSH configuration..."

if command -v sshd >/dev/null 2>&1; then
    echo "[OK] SSH server is installed."
    sshd -t && echo "[OK] SSH configuration syntax is valid."
else
    echo "[INFO] SSH server is not installed."
fi

echo ""
echo "=========================================="
echo " Linux hardening checks completed."
echo "=========================================="
```

---

# 🧪 Verification Commands

Check the current user:

```bash
whoami
```

Check the current directory:

```bash
pwd
```

Check project files:

```bash
ls -la
```

Check the hardening script:

```bash
ls -l harden.sh
```

Display the script:

```bash
cat harden.sh
```

Check UFW status:

```bash
sudo ufw status verbose
```

---

# 📊 Final Firewall Result

```text
Status: active
Logging: on (low)

Default: deny (incoming)
Default: allow (outgoing)

22/tcp      ALLOW IN    Anywhere
22/tcp (v6) ALLOW IN    Anywhere (v6)
```

---

# 📸 Screenshots

The `screenshots/` directory contains evidence of:

```text
1. Linux/WSL environment
2. Hardening script
3. UFW firewall configuration
4. UFW active status
5. SSH configuration check
```

---

# ⚠️ Disclaimer

This project was performed in a controlled personal WSL2 environment for cybersecurity learning and educational purposes.

The firewall and security configuration should be reviewed according to the actual services required on a production system.

---

# 👨‍💻 Author

**Injmam**

Cybersecurity Intern — GetIntern
