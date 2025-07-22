#! /usr/bin/bash

############################################################
# Step. rocPRIMT
############################################################
cd ~/linux
git clone https://github.com/ROCm/pytorch
cd pytorch

#git checkout rocm_upgrade_CI_5.4 --force
git checkout rocm_nightly_5.4 --force
git submodule update --init --recursive

export CXX=/usr/bin/g++-14
export CC=/usr/bin/gcc-14

python3 tools/amd_build/build_amd.py

cmake -S . -B build-dir -Wno-dev \
 -DCMAKE_CXX_FLAGS="-Wno-deprecated-builtins -Wno-defaulted-function-deleted -Wno-deprecated-declarations -Wno-tautological-compare -Wno-dangling-reference -Wno-pessimizing-move -Wno-uninitialized -Wno-maybe-uninitialized" \ 
 -DAMDGPU_TARGETS=$GPU_REV \
 -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
 -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
 -DROCM_PATH=/opt/rocm \
 -DCMAKE_PREFIX_PATH="/opt/rocm;/opt/rocm/hip;/opt/rocm/hip/lib;/opt/rocm/hip/lib/cmake" \
 -DUSE_ROCTRACER=OFF \
 -DUSE_ROCM_PROFILER=OFF \
 -DUSE_ROCM=ON \
 -DUSE_CUDA=OFF \
 -DUSE_MAGMA=OFF \
 -DUSE_OPENMP=OFF \
 -DONEDNN_BUILD_OMP=OFF \
 -DUSE_MKLDNN=OFF \
 -DUSE_BACKTRACE=OFF \
 -DUSE_FBGEMM=OFF \
 -DUSE_CAFFE2=OFF \
 -DUSE_MPI=OFF \
 -DUSE_KINETO=OFF \
 -DUSE_XNNPACK=OFF \
 -Dhip_DIR=/opt/rocm/hip/lib/cmake/hip

# compile, will fail
cmake --build build-dir -j$JOBS
git stash apply
cmake --build build-dir -j$JOBS

# install 
#cmake --install build-dir

