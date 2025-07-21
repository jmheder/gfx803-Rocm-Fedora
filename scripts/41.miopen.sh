#! /usr/bin/bash

############################################################
# Step. rocPRIMT
############################################################
cd ~/linux
git clone https://github.com/ROCm/MIOpen
git submodule update --init --recursive --force

cd MIOpen
git checkout release/rocm-rel-5.4.02.01 --force

export CXX=/opt/rocm/llvm/bin/clang++
export CC=/opt/rocm/llvm/bin/clang
export LD=/opt/rocm/llvm/bin/ld.lld

cmake -S . -B build-dir \
 -DROCM_PATH=/opt/rocm \
 -DCMAKE_PREFIX_PATH=/opt/rocm \
 -DHALF_INCLUDE_DIR=/opt/rocm/include/half/ \
 -DAMDGPU_TARGETS=$GPU_REV \
 -DCMAKE_LIBRARY_PATH="/opt/rocm/lib64;/opt/rocm/hip/lib" \
 -DMIOPEN_USE_HIPBLASLT=OFF \
 -DMIOPEN_USE_MLIR=OFF \
 -DMIOPEN_USE_COMPOSABLEKERNEL=OFF \
 -DBoost_USE_STATIC_LIBS=OFF

# -DMIOPEN_TEST_ALL=OFF \
#-DCMAKE_SHARED_LINKER_FLAGS="-fuse-ld=lld" \
# -DAMDGPU_TARGETS=$GPU_REV \
# -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
# -DROCM_PATH=/opt/rocm \
# -DCMAKE_PREFIX_PATH=/opt/rocm \
# -DMIOPEN_USE_HIPBLASLT=OFF \
# -DMIOPEN_USE_MLIR=OFF \
# -DHALF_INCLUDE_DIR=/opt/rocm/include/half/ \
# -DMIOPEN_USE_COMPOSABLEKERNEL=OFF \
# -DCMAKE_PREFIX_PATH="/opt/rocm;/opt/rocm/hip" \
# -DCMAKE_LIBRARY_PATH="/opt/rocm/lib64;/opt/rocm/hip/lib" \
# -DCMAKE_PREFIX_PATH="/opt/rocm;/opt/rocm/hip" \
# -DCMAKE_LINKER=/opt/rocm/llvm/bin/ld.lld \
# -DCMAKE_C_COMPILER=/opt/rocm/llvm/bin/clang \
# -DCMAKE_CXX_COMPILER=/opt/rocm/llvm/bin/clang++ \
# -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld"


# compile
cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir

