#/bin/bash
#docker run --init --runtime=nvidia --name=autonomous_sys_build --rm -it -e DISPLAY=:1 -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0:rw -p 443:40001 autonomous_sys_build
nvidia-docker run --init --name=ros-gpu --rm -it -e DISPLAY=:1 -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0:rw -p 443:40001 robopaas/rosdocked-kinetic-workspace-included-gpu:latest
