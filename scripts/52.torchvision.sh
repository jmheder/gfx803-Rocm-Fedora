#! /usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################
# Step. rocPRIMT
############################################################
cd ~/linux
git clone --branch v0.16.0 https://github.com/pytorch/vision.git
cd vision

git submodule update --init --recursive

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14


export USE_ROCM=1
export ROCM_PATH=/opt/rocm
export HPI_PATH=/opt/rocm/hip
export PYTORCH_ROCM_ARCH="gfx803"   # Important for correct HIP target
export CMAKE_PREFIX_PATH="/opt/rocm;/opt/rocm/llvm"
export hip_DIR=/opt/rocm/hip/lib/cmake/hip

#export PYTORCH_BUILD_VERSION=2.1
#export PYTORCH_BUILD_NUMBER=0

#python setup.py install
CMAKE_COMMAND=cmake3 python setup.py bdist_wheel


