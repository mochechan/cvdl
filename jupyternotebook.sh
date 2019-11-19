#!/bin/bash


docker run -it --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "$PWD:/home/jovyan/work"  -v "/tmp/.X11-unix:/tmp/.X11-unix" -v "/tmp/.docker.xauth:/tmp/.docker.xauth" -e "XAUTHORITY=/tmp/.docker.xauth" --device=/dev/video0 -e DISPLAY=$DISPLAY --env QT_X11_NO_MITSHM=1  jupyter/datascience-notebook

