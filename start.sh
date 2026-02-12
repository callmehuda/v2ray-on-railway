#!/bin/sh
set -e

# Install SSH (sekali build)
# (ini sebaiknya di Dockerfile, bukan di runtime)

# Setup SSH
echo 'root:huda' | chpasswd
ssh-keygen -A
echo -e "Port 22\nListenAddress 127.0.0.1\nPermitRootLogin yes\nPasswordAuthentication yes" | tee /etc/ssh/sshd_config
mkdir -p /run/sshd
chmod 755 /run/sshd

# Start sshd (background)
/usr/sbin/sshd

# Start Xray (foreground)
exec xray -config /etc/xray/config.json