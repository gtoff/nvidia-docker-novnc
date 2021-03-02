# Scripts to set up RAP course VMs

The following steps should configure the VMs to run GPU accelerated docker containers with noVNC.

1) clone this repo in /opt --> VERY IMPORTANT or wont't work

Run:

    sudo ./setup-host.sh

After this you can try if the system runs properly by using our container:

    ./run.sh
    
To verify it works: 
- connect to https://VM_IP with your browser
- accept the self-signed certificate
- use terminator on the desktop to launch 'glxgears'
- use the same terminator to run our robotic simulations

# Notes

In order for a display manager to run properly, on our GPU VMs I had to configure X to use the nvidia cards. This works by launching nvidia-xconfig.

On our GPU VMs lightdm/gdm3 were not starting. Problem was Xorg.conf missing the right device (nvidia GPU).
Running nvidia-xconfig set up a working Xorg.conf and got gdm to run.

Still, any application launched from console won't find DISPLAY=:0. One way to see active sessions is:

    loginctl list-sessions
  
Then the following command should show the DISPLAY for the session:

    loginctl show-session -p Display -p Active <session-id>
  
That did not work. After installing and uninstalling gdm3 and lightdm I realized lightdm managed to start X with display :0

    ubuntu@rap-lab-vm:~$ sudo systemctl status display-manager.service 
● lightdm.service - Light Display Manager
   Loaded: loaded (/lib/systemd/system/lightdm.service; indirect; vendor preset: enabled)
   Active: active (running) since Tue 2021-01-19 12:58:35 UTC; 10min ago
     Docs: man:lightdm(1)
 Main PID: 3617 (lightdm)
    Tasks: 6 (limit: 4915)
   CGroup: /system.slice/lightdm.service
           ├─3617 /usr/sbin/lightdm
           ├─3630 /usr/lib/xorg/Xorg -core :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp
           └─3835 lightdm --session-child 13 20

Then, using the setup_host scripts I can connect with xauth using the lightdm user and add xauth permissions.


# Original documentation below


![Preview Image](https://cdn-images-1.medium.com/max/1600/1*wKNrdA3rqpHZU82DU4gVPA.gif)

### Building a GPU-enhanced Lubuntu Desktop with nvidia-docker2

To build on a plain vanilla Google Compute GPU host:

1. Spin up a GC GPU host on the google console.  Make sure it has at least one Tesla K80 GPU, and decent amount of VCPUs (e.g. 4, and enough disk space, at least 50Gb). Zone `us-east-1c` seems to be the best choice as of April 1, 2018.
1. Upload this repo and unpack it in `/root/build` or wherever you like as a temporary location.
1. Run `preinstall.sh`. This just runs `apt-get update` and puts in `screen` and `emacs` for getting started.
1. Run `build.sh`. This will build everything needed to start up a nvidia-docker2 container with Ubuntu 16.04 and Lubuntu desktop.

![SetupImage1](https://user-images.githubusercontent.com/176268/38177239-00283584-35b3-11e8-9c84-4f788120caca.png)
![Setupimage2](https://user-images.githubusercontent.com/176268/38177244-0b6b4d3c-35b3-11e8-8605-ed184afa59a6.png)

### Running the container

To run the container on this host, use `run.sh`. Note that NoVNC will
expect connections on port 40001. Then surf to your host on that port.

### Setting up network access

Thanks to @moorage for these tips on configuring network access.

https://github.com/willkessler/nvidia-docker-novnc/issues/2


### More info

For more links and reference, please see the Medium posting about this environment [here](https://engineering.udacity.com/creating-a-gpu-enhanced-virtual-desktop-for-udacity-497bdd91a505).


