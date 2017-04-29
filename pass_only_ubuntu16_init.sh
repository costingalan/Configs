#!/bin/bash

# Managed by hades
export default_password="${hades_password}"
# Managed by hades

apt-get update -y
apt-get install vim git wget -y
useradd cgalan
usermod -G sudo cgalan
echo "AllowUsers cgalan" >> /etc/ssh/sshd_config
echo "cgalan:${default_password}" | chpasswd
chage -d0 cgalan

apt-get install fail2ban
touch /etc/fail2ban/jail.local
echo "[ssh-iptables]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "filter = sshd" >> /etc/fail2ban/jail.local
echo "action = iptables[name=SSH, port=ssh, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "logpath = /var/log/auth.log" >> /etc/fail2ban/jail.local
update-rc.d fail2ban defaults

reboot

