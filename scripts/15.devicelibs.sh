#! /usr/bin/bash

############################################################################################
# Step. Rocm Device libs
############################################################################################
cd ~/linux/llvm-project
git clone https://github.com/RadeonOpenCompute/ROCm-Device-Libs.git
cd ROCm-Device-Libs/
git checkout rocm-5.4.1 #--force

# we have an issue with "-strip" in one make file 

#export CXX=/opt/rocm/llvm/bin/clang++
#export CC=/opt/rocm/llvm/bin/clang
#export Ld=/opt/rocm/llvm/bin/ld.lld

mkdir -p build-dir
cd build-dir

cmake .. \
  -DCMAKE_PREFIX_PATH=/opt/rocm \
  -DCMAKE_PREFIX_PATH=ĩnux/llvm-project \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
  -DCMAKE_C_COMPILER=/opt/rocm/llvm/bin/clang \
  -DCMAKE_CXX_COMPILER=/opt/rocm/llvm/bin/clang++ \
  -DLLVM_EXTERNAL_DEVICE_LIBS_SOURCE_DIR=~/linux/llvm-project 
  
#  -DAMDGPU_TARGETS="gfx803" \
#  -DAMDGPU_BACKEND="AMDGPU" \
#  -DDEVICE_LIBS_TO_BUILD="ocml" \
#  -DAMDGPU_ENABLE_AMDHSA=ON
cd .. 
# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir


