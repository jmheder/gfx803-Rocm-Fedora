#! /usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################
# Step. half 
############################################################
cd ~/linux
git clone https://github.com/ROCmSoftwarePlatform/half.git
cd half

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14

cmake -S . -B build-dir

cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir

