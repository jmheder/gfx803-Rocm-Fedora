#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################################################
# Step. roc runtime 
############################################################################################
cd ~/linux

git clone https://github.com/RadeonOpenCompute/ROCR-Runtime.git
cd ROCR-Runtime
git checkout rocm-5.4.1

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14

mkdir -p build-dir
cmake -S src -B build-dir \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir

