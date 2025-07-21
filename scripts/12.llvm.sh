#! /usr/bin/bash

##############################################
# Step. llvm
##############################################
# clone master rocm
git clone https://github.com/RadeonOpenCompute/llvm-project.git ~/linux/llvm-project

cd llvm-project
git checkout rocm-5.4.1 --force

mkdir -p build-llvm
cmake -S llvm -B build-llvm \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
  -DCMAKE_INSTALL_PREFIX=$LLVM_PATH \
  -DLLVM_ENABLE_PROJECTS="llvm" \
  -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" \
  -DCMAKE_PREFIX_PATH=$LLVM_PATH \
  -DBUILD_SHARED_LIBS=OFF \
  -DBUILD_STATIC_LIBS=ON

# Broken stuff everywhere, missing includes (cstdint or stdint.h)
/usr/bin/sed -i "/#include <new>/a #include <cstdint>" ~/linux/llvm-project/llvm/include/llvm/ADT/SmallVector.h
/usr/bin/sed -i "14i#include <cstdint>" ~/linux/llvm-project/llvm/include/llvm/OffloadArch/OffloadArch.h
/usr/bin/sed -i "17i#include <cstdint>" ~/linux/llvm-project/llvm/lib/Target/X86/MCTargetDesc/X86MCTargetDesc.h
/usr/bin/sed -i "17i#include <cstdint>" ~/linux/llvm-project/llvm/lib/Target/AMDGPU/MCTargetDesc/AMDGPUMCTargetDesc.h

# compile
cmake --build build-llvm -j$JOBS

# install
cmake --install build-llvm
