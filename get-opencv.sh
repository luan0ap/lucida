#!/usr/bin/env bash

# Install OpenCV
# jahausw@umich.edu
# 2014

hash wget 2>/dev/null || {
  echo >&2 "$0: [ERROR] wget is not installed. Aborting."
  exit 1
}

hash unzip 2>/dev/null || {
  echo >&2 "$0: [ERROR] unzip is not installed. Aborting."
  exit 1
}

if [ "$EUID" -ne 0 ]
then
  echo >&2 "$0: [ERROR] Sudo access required. Aborting."
  exit 1
fi

# Get tessaract
apt-get install \
  tesseract-ocr tesseract-ocr-eng libtesseract-dev libleptonica-dev

# Get correct opencv
apt-get install \
  build-essential checkinstall git cmake libfaac-dev libjack-jackd2-dev \
  libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev \
  libtheora-dev libva-dev libvdpau-dev libvorbis-dev libx11-dev libxfixes-dev \
  libxvidcore-dev texi2html yasm zlib1g-dev

open=opencv-
ver=2.4.9
base=${open}${ver}
wget \
  http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/$ver/$base.zip
unzip $base;
cd $base;

# mkdir build;
# cmake -DCMAKE_INSTALL_PREFIX:PATH=`pwd`/build
cmake .
make -j 8
make install

cd ..;  rm -rf $base*
