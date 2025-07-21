#! /usr/bin/bash

############################################################
# Step. half 
############################################################
cd ~/linux
git clone https://github.com/ROCmSoftwarePlatform/half.git
cd half
mkdir build-dir && cd build-dir
cmake ..

# compile
cmake --build build-dir -j$JOBS

# install 
cmake --install build-dir

