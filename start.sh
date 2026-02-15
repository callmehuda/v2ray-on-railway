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
apt install python3 python3-pip -y
python3 -m venv myvenv
apt install fish

# Start sshd (background)
/usr/sbin/sshd

# Start Xray (foreground)
exec xray -config /etc/xray/config.json