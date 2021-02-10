#!/bin/bash

export DISPLAY=":0"
# This xhost command is key to getting Lubuntu working properly with nvidia-driven GPU support.
xhost +si:localuser:root
xhost +si:localuser:ubuntu
