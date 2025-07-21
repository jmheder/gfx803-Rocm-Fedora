#! /usr/bin/bash

# this might not be needed, anyways lets do it
/usr/bin/python3.10 -m venv venv
source venv/bin/activate
pip3 install --upgrade pip
pip3 install pyyaml msgpack 

# Set new path, /opt/rocm must "rule"
export PATH=/opt/rocm:/opt/rocm/bin:/opt/rocm/hip/bin:$PATH

export AMDGPU_TARGETS="gfx803"
export JOBS=$(( $(nproc) - 4 ))
export GPU_REV="gfx803"
export RELEASE_TYPE=Release
export ROCM_PATH=/opt/rocm
export LLVM_PATH=/opt/rocm/llvm
export HIP_PATH=/opt/rocm/hip
export HIP_BIN_DIR=/opt/rocm/bin
export PATH=$ROCM_PATH/bin:$ROCM_PATH/hip/bin:/opt/rocm/llvm/bin:$PATH
export LIBRARY_PATH=/opt/rocm/lib:/opt/rocm/lib64:/opt/rocm/llvm/lib:/opt/rocm/hip/lib:/lib64:/lib:/usr/lib:/usr/local/lib
export LD_LIBRARY_PATH=/opt/rocm/lib:/opt/rocm/lib64:/opt/rocm/lib:/opt/rocm/lib64:/opt/rocm/lib:/opt/rocm/lib64:/opt/rocm/llvm/lib:/opt/rocm/hip/lib:/lib64:/lib:/usr/lib:/usr/local/lib
