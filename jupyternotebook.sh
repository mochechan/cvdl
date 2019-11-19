#!/bin/bash

xhost +local:docker
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
echo sudo docker run -it --device=/dev/video0　-e DISPLAY=$DISPLAY --env QT_X11_NO_MITSHM=1 -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH dockergui/v1
xhost -local:docker

#docker run -it --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "$PWD":/home/jovyan/work jupyter/datascience-notebook

