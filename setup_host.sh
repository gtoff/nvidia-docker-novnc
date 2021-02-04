#!/bin/bash
if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi


echo "Copying xorg.conf to X config dir"
cp setup_host/xorg.conf /etc/X11
echo "Installing lightdm"
exec setup_host/basics.sh
echo "Starting lightdm"
systemctl start --wait display-manager.service
echo "Adding users to lightdm xhost"
exec setup_host/add_xhost.sh
