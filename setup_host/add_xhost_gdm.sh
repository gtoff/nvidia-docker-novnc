#!/bin/bash

perl -pi -e 's/^gdm:(.*)(\/bin\/false)$/gdm:$1\/bin\/bash/' /etc/passwd
export DISPLAY=":0"
#service lightdm start
# Critical to wait a bit: you can't run xhost too fast after x starts
#sleep 5
#
# This xhost command is key to getting Lubuntu working properly with nvidia-driven GPU support.
#
su - gdm -c "xhost +si:localuser:root"
su - gdm -c "xhost +si:localuser:ubuntu"
su - gdm -c "xhost +si:localuser:docker"
perl -pi -e 's/^gdm:(.*)(\/bin\/bash)$/gdm:$1\/bin\/false/' /etc/passwd
