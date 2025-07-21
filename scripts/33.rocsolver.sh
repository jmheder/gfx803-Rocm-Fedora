#! /usr/bin/bash

############################################################
# Step. rocPRIMT
############################################################
cd ~/linux
git clone https://github.com/ROCmSoftwarePlatform/rocSOLVER.git
cd rocSOLVER
git checkout rocm-5.4.1

export CXX=/opt/rocm/bin/hipcc
export CC=/opt/rocm/bin/hipcc

cmake -S . -B build-dir \
 -DAMDGPU_TARGETS=$GPU_REV \
 -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
 -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
 -DROCM_PATH=/opt/rocm \
 -DCMAKE_PREFIX_PATH=/opt/rocm

# compile
cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir

