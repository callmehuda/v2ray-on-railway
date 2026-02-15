#!/bin/sh
set -e

# Install SSH (sekali build)
# (ini sebaiknya di Dockerfile, bukan di runtime)

# Setup SSH
echo 'root:huda' | chpasswd
ssh-keygen -A
printf "Port 22\nListenAddress 127.0.0.1\nPermitRootLogin yes\nPasswordAuthentication yes\nSubsystem sftp internal-sftp\n" | tee /etc/ssh/sshd_config
mkdir -p /run/sshd
chmod 755 /run/sshd
apt update && apt upgrade -y
apt install python3 python3-pip python3.12-venv python3-ensurepip fish -y
python3 -m venv myvenv

# Start sshd (background)
/usr/sbin/sshd

# Start Xray (foreground)
exec xray -config /etc/xray/config.json