#! /usr/bin/bash

##############################################
# Step. thunk
##############################################
git clone https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface.git
cd ROCT-Thunk-Interface
git checkout rocm-5.4.1 --force

mkdir build-dir
cmake -S . -B build-dir \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir