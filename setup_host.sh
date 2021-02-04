#!/bin/bash
if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi


echo "Copying xorg.conf to X config dir"
cp setup_host/xorg.conf /etc/X11
echo "Installing lightdm"
apt remove -y gdm3
setup_host/basics.sh
echo "Starting lightdm"
systemctl start display-manager.service
echo "Adding users to lightdm xhost"
setup_host/add_xhost.sh
