#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################################################
# Step. opencl
############################################################################################
cd ~/linux
git clone https://github.com/ROCm/ROCclr.git
cd ROCclr
git checkout rocm-5.4.1 --force

# enable opencl on gfx803 permanemtly
/usr/bin/sed -i '1366i if (0)' ./device/device.hpp

cd ~/linux
git clone https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime.git
cd ROCm-OpenCL-Runtime
git checkout rocm-5.4.1 --force

export CC=/opt/rocm/llvm/bin/clang
export CXX=/opt/rocm/llvm/bin/clang++

mkdir -p build-dir
cmake -S . -B build-dir \
 -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
 -DBUILD_TESTING=ON \
 -DCMAKE_BUILD_TYPE=$RELEASE_TYPE

# compile
cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir

