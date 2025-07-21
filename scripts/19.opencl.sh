#! /usr/bin/bash

############################################################################################
# Step. opencl
############################################################################################
cd ~/linux
git clone https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime.git
cd ROCm-OpenCL-Runtime
git checkout rocm-5.4.1

mkdir -p build-dir
cmake -S . -B build-dir \
 -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
 -DCMAKE_BUILD_TYPE=$RELEASE_TYPE

# compile
cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir

