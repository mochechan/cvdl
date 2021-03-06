# docker build --tag dockergui/v1 .

FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

# Essentials: developer tools, build tools, OpenBLAS
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils git curl vim unzip openssh-client wget \
    x11-apps ffmpeg eog \
    build-essential cmake \
    libgtk2.0-dev \
    pkg-config \
    libopenblas-dev

#
# Python 3.5
#
# For convenience, alias (but don't sym-link) python & pip to python3 & pip3 as recommended in:
# http://askubuntu.com/questions/351318/changing-symlink-python-to-python3-causes-problems
RUN apt-get install -y --no-install-recommends python3.8 python3.8-dev python3-pip python3-tk && \
    pip3 install --no-cache-dir --upgrade pip setuptools && \
    echo "alias python='python3'" >> /root/.bash_aliases && \
    echo "alias pip='pip3'" >> /root/.bash_aliases
# Pillow and it's dependencies
RUN apt-get install -y --no-install-recommends libjpeg-dev zlib1g-dev && \
    pip3 --no-cache-dir install Pillow
# Science libraries and other common packages
RUN pip3 --no-cache-dir install \
    numpy scipy sklearn scikit-image pandas matplotlib imutils requests

#
# Tensorflow - CPU
#
RUN pip3 install --no-cache-dir --upgrade tensorflow 

# Expose port for TensorBoard
EXPOSE 6006

#
# OpenCV 3.4.1
#S
RUN wget -q -P /usr/local/src/ --no-check-certificate https://github.com/opencv/opencv/archive/3.4.1.zip
RUN cd /usr/local/src/ \
 && unzip 3.4.1.zip \
 && rm 3.4.1.zip \
 && cd /usr/local/src/opencv-3.4.1/ \
 && mkdir build \
 && cd /usr/local/src/opencv-3.4.1/build \ 
 && cmake -D CMAKE_INSTALL_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local/ .. \
 && make -j4 \
 && make install \
&& rm -rf /usr/local/src/opencv-3.4.1


# Keras
#
RUN git clone --depth 1 https://github.com/fchollet/keras.git /usr/src/keras && \
    pip install keras

#
# PyTorch 0.3.1
#
#RUN pip3 install http://download.pytorch.org/whl/cpu/torch-0.3.1-cp35-cp35m-linux_x86_64.whl && \
#pip3 install torchvision

# Setting up working directory 
RUN mkdir /js
WORKDIR /js

# Minimize image size 
RUN (apt-get autoremove -y; \
apt-get autoclean -y)

CMD ["/bin/bash"]

# https://gist.github.com/boyz357159/da5d7d1c7ff4e42690d4eba8f09feb2d
