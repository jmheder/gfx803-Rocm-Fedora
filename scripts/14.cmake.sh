#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################################################
# Step. cmake 
############################################################################################
git clone https://github.com/RadeonOpenCompute/rocm-cmake.git
cd rocm-cmake
git checkout rocm-5.4.1 --force

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14

mkdir -p build-dir
cmake -S . -B build-dir -DCMAKE_INSTALL_PREFIX=$ROCM_PATH

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir


