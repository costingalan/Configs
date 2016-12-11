#!/bin/bash

yum install epel-release -y
yum update -y
yum install vim git wget yum-cron yum-utils deltarpm -y
useradd cgalan
usermod -G wheel cgalan
echo "AllowUsers cgalan" >> /etc/ssh/sshd_config
echo 'cgalan:super-s3cur3' | chpasswd
chage -d0 cgalan
reboot

