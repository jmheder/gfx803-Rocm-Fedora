#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

##############################################
# Step. thunk
##############################################
git clone https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface.git
cd ROCT-Thunk-Interface
git checkout rocm-5.4.1 --force

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14

mkdir build-dir
cmake -S . -B build-dir \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir