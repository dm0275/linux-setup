#!/bin/bash

PKG_MGR=""

if [[ $UID != 0 ]]; then
    echo "Please run this script as sudo:"
    echo "sudo $0 $*"
    exit 1
fi

 if [[ ! -z $(which yum) ]]; then
    PKG_MGR=$(which yum)
 elif [[ ! -z $(which apt-get) ]]; then
    PKG_MGR=$(which apt-get)
 else
    echo "Neither yum or apt-get are installed"
    exit 1;
 fi

PACKAGES=(ansible curl git)
$PKG_MGR install -y ${PACKAGES[*]}

git clone https://github.com/dm0275/linux-setup-ansible.git
ansible-playbook init.yml