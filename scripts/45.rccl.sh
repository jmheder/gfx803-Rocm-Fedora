#! /usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

# === Configuration ===
INSTALL_PREFIX=/opt/rocm

# === Clone RCCL ===
git clone https://github.com/ROCm/rccl.git
cd rccl
git checkout rocm-5.4.1 

# === Set environment variables ===
export HIP_PLATFORM=amd
export CXX=hipcc

# === Build RCCL ===
mkdir -p build-dir

# make needs two targets minimum

cmake -S . -B build-dir \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} \
  -DCMAKE_BUILD_TYPE=Release

# compile
cmake --build build-dir -j$JOBS

cmake --install build-dir
