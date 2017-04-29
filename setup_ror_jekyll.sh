#!/bin/bash

set -euox pipefail


cd /tmp
curl -sSL https://get.rvm.io > ruby_install
chmod 755 ruby_install
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 
./ruby_install stable --ruby 

yum install epel-release -y
yum install npm nodejs -y
yum update -y

