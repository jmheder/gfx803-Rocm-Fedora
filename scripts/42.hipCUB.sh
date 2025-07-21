#! /usr/bin/bash

############################################################
# Step. half 
############################################################
git clone https://github.com/ROCmSoftwarePlatform/hipCUB.git
cd hipCUB
git checkout rocm-5.4.1
mkdir build-dir
cd build-dir

export CC=$ROCM_PATH/llvm/bin/clang
export CXX=$ROCM_PATH/llvm/bin/clang++

cmake .. \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
  -DCMAKE_BUILD_TYPE=Release \
  -DAMDGPU_TARGETS=$AMDGPU_TARGET

cd ..

# compile
cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir
