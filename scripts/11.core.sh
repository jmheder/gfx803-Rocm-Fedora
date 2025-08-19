#!/usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

##############################################
# Step. thunk
##############################################

git clone https://github.com/ROCm/rocm-core.git
cd rocm-core
git checkout rocm-5.5.x --force

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14

cmake -S . -B build-dir \
  -DCMAKE_VERBOSE_MAKEFILE=1 \
  -DROCM_VERSION="5.4.1" \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir