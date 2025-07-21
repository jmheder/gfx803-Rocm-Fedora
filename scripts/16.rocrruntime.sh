#! /usr/bin/bash

############################################################################################
# Step. roc runtime 
############################################################################################
cd ~/linux

git clone https://github.com/RadeonOpenCompute/ROCR-Runtime.git
cd ROCR-Runtime
git checkout rocm-5.4.1

mkdir -p build-dir
cmake -S src -B build-dir \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE
  -DCMAKE_C_COMPILER=/opt/rocm/llvm/bin/clang \
  -DCMAKE_CXX_COMPILER=/opt/rocm/llvm/bin/clang++

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir

