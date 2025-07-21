#! /usr/bin/bash

############################################################
# Step. rocThrust
############################################################

git clone https://github.com/ROCmSoftwarePlatform/rocThrust.git
cd rocThrust
git checkout rocm-5.4.1
mkdir build-dir


cmake -S . -B build-dir \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
  -DCMAKE_BUILD_TYPE=Release \
  -DAMDGPU_TARGETS=$AMDGPU_TARGET \
  -DCMAKE_C_COMPILER=$ROCM_PATH/llvm/bin/clang \
  -DCMAKE_CXX_COMPILER=$ROCM_PATH/bin/hipcc

# compile
cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir