#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

##############################################
# Step. clang and friends
##############################################

cd ~/linux/llvm-project
git checkout rocm-5.4.1 --force

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14

mkdir -p build-dir
cmake -S llvm -B build-dir \
  -DCMAKE_INSTALL_PREFIX=$LLVM_PATH \
  -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt;lld" \
  -DAMDGPU_TARGETS=$GPU_REV \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" \
  -DLLVM_ENABLE_RTTI=ON \
  -DLLVM_ENABLE_BINDINGS=OFF \
  -DLLVM_ENABLE_WARNINGS=OFF

# broken stuff
/usr/bin/sed -i '41a #include <string>' ~/linux/llvm-project/clang/tools/amdgpu-arch/dynamic_hsa/../../../../openmp/libomptarget/include/Debug.h
/usr/bin/sed -i '41a #include <cstdlib>' ~/linux/llvm-project/clang/tools/amdgpu-arch/dynamic_hsa/../../../../openmp/libomptarget/include/Debug.h
/usr/bin/sed -i '18a #include <cstdlib>' ~/linux/llvm-project/llvm/lib/Target/AMDGPU/MCTargetDesc/AMDGPUMCTargetDesc.h
/usr/bin/sed -i '14a #include <cstdint>' ~/linux/llvm-project/llvm/include/llvm/OffloadArch/OffloadArch.h

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir
