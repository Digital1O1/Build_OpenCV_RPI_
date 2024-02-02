#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade
# dependencies
sudo apt-get -y install build-essential cmake git unzip pkg-config
sudo apt-get -y  install libjpeg-dev libpng-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get -y install libgtk2.0-dev libcanberra-gtk* libgtk-3-dev
sudo apt-get -y install libgstreamer1.0-dev gstreamer1.0-gtk3
sudo apt-get -y install libgstreamer-plugins-base1.0-dev gstreamer1.0-gl
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install python3-dev python3-numpy python3-pip
sudo apt-get -y install libtbb2 libtbb-dev libdc1394-22-dev
sudo apt-get -y install libv4l-dev v4l-utils
sudo apt-get -y install libopenblas-dev libatlas-base-dev libblas-dev
sudo apt-get -y install liblapack-dev gfortran libhdf5-dev
sudo apt-get -y install libprotobuf-dev libgoogle-glog-dev libgflags-dev
sudo apt-get -y install protobuf-compiler
sudo apt-get -y install qt5-default

cd ~
git clone --depth=1 https://github.com/opencv/opencv.git
git clone --depth=1 https://github.com/opencv/opencv_contrib.git

cd ~/opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D ENABLE_NEON=ON \
-D WITH_OPENMP=ON \
-D WITH_OPENCL=OFF \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D WITH_GSTREAMER=ON \
-D BUILD_TESTS=OFF \
-D WITH_EIGEN=OFF \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D WITH_VTK=OFF \
-D WITH_QT=ON \
-D WITH_PROTOBUF=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D OPENCV_FORCE_LIBATOMIC_COMPILER_CHECK=1 \
-D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D WITH_ONNX=ON \
-D BUILD_EXAMPLES=ON ..
make -j4

sudo make install
sudo ldconfig
make clean
sudo apt-get -y update
sudo rm -rf ~/opencv
sudo rm -rf ~/opencv_contrib
