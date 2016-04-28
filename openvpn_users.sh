#!/bin/bash

set -euox pipefail

echo "Creating config file for $1 ..."

mkdir "/tmp/$1"
pushd "/tmp/$1"
    cp /etc/openvpn/easy-rsa/keys/{default.ovpn,ca.crt,$1.crt,$1.key} .
    sed -i s/cgalan/$1/g default.ovpn
    mv default.ovpn $1.ovpn
    cd ..
    tar -zcvf $1.tar.gz $1
popd

echo "The package for $1 is  /tmp/$1/$1.tar.gz"
