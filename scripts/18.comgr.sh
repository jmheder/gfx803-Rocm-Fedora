#! /usr/bin/bash

############################################################################################
# Step. standalone amd_comgr
############################################################################################
cd ~/linux
git clone https://github.com/ROCm/ROCm-CompilerSupport.git
cd ROCm-CompilerSupport
git checkout rocm-5.4.1 --force

mkdir -p build-dir
cmake -S ./lib/comgr/ -B build-dir \
 -DLLVM_DIR=/opt/rocm/llvm \
 -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
 -DAMDGPU_COMPGR=ON \
 -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
 -DCMAKE_INSTALL_PREFIX=$ROCM_PATH

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir
