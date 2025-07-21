#! /usr/bin/bash

############################################################
# Step. rocfft
############################################################
cd ~/linux
git clone https://github.com/ROCmSoftwarePlatform/rocFFT.git
cd rocFFT
git checkout rocm-5.4.1 --force

mkdir -p build-dir
cd build-dir

# ensure skip all target except from gfx803 
sed -i '150s/TARGETS .*/TARGETS "gfx803")/' ~/linux/rocFFT/CMakeLists.txt

export CXX=/opt/rocm/bin/hipcc
export CC=/opt/rocm/bin/hipcc

cmake .. \
 -DAMDGPU_TARGETS=$GPU_REV \
 -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
 -DCMAKE_BUILD_TYPE=$RELEASE_TYPE

cd ..

# compile
cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir
