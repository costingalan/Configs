#!/bin/bash

set -euox pipefail

# Managered by hades
EXPORT default_password="${hades_meta}"
# Managered by hades

yum install epel-release -y
yum update -y
yum install vim git wget yum-cron yum-utils deltarpm -y
useradd cgalan
usermod -G wheel cgalan
echo "AllowUsers cgalan" >> /etc/ssh/sshd_config
echo "cgalan:${default_password}" | chpasswd
chage -d0 cgalan
reboot

