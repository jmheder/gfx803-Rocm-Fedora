#! /usr/bin/bash

cd ~/linux
############################################################################################
# Step. rocminfo
############################################################################################
# Clone the repo
git clone https://github.com/RadeonOpenCompute/rocminfo.git
cd rocminfo
git checkout rocm-5.4.1 --force

mkdir -p build-dir
cmake -S . -B build-dir \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir