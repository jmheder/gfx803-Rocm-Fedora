#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################################################
# Step. standalone amd_comgr
############################################################################################
cd ~/linux
git clone https://github.com/ROCm/ROCm-CompilerSupport.git
cd ROCm-CompilerSupport
git checkout rocm-5.4.1 --force

export CC=/opt/rocm/llvm/bin/clang
export CXX=/opt/rocm/llvm/bin/clang++

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
