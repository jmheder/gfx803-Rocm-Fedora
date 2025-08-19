#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################################################
# Step. rocminfo
############################################################################################
# Clone the repo
cd ~/linux
git clone https://github.com/RadeonOpenCompute/rocminfo.git
cd rocminfo
git checkout rocm-5.4.1 --force

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14

mkdir -p build-dir
cmake -S . -B build-dir \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir