#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################################################
# Step. hipcc
# We'll miss some share/ scripts, but hipcc will fallback to and and everything will be ok
############################################################################################
cd ~/linux
export ROCM_BRANCH=rocm-5.4.1
git clone -b "$ROCM_BRANCH" https://github.com/ROCm-Developer-Tools/hipamd.git
git clone -b "$ROCM_BRANCH" https://github.com/ROCm-Developer-Tools/hip.git
git clone -b "$ROCM_BRANCH" https://github.com/ROCm-Developer-Tools/ROCclr.git
git clone -b "$ROCM_BRANCH" https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime.git

export CC=/opt/rocm/llvm/bin/clang
export CXX=/opt/rocm/llvm/bin/clang++

cd hipamd
git submodule update --init --recursive
cd ..
cd hip
git submodule update --init --recursive
cd ..
cd ROCclr
git submodule update --init --recursive
cd ..
cd ROCm-OpenCL-Runtime
git submodule update --init --recursive
cd ..



export HIPAMD_DIR="$(readlink -f hipamd)"
export HIP_DIR="$(readlink -f hip)"
echo $HIPAMD_DIR
cd "$HIPAMD_DIR"
mkdir -p build-dir

# required to enter the library, otherwise it will fail to find hip_pch.o (generated in ".")
cd build-dir
cmake .. \
  -DHIP_COMMON_DIR=$HIP_DIR \
  -DCMAKE_PREFIX_PATH=$ROCM_PATH \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
  -DHIP_PLATFORM=amd \
  -DHIP_RUNTIME=rocclr \
  -DHIP_COMPILER=clang

cd ..


# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir
