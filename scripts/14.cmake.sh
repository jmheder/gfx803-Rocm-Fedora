#! /usr/bin/bash

############################################################################################
# Step. cmake 
############################################################################################
git clone https://github.com/RadeonOpenCompute/rocm-cmake.git
cd rocm-cmake
git checkout rocm-5.4.1 --force

mkdir -p build-dir
cmake -S . -B build-dir -DCMAKE_INSTALL_PREFIX=$ROCM_PATH

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir


