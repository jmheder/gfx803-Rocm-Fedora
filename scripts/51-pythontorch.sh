############################################################
# Step. rocPRIMT
############################################################
cd ~/linux
#git clone https://github.com/ROCm/pytorch
cd pytorch

#git checkout rocm_upgrade_CI_5.4 --force
#git checkout rocm_nightly_5.4 --force

# 2.1 starts -----------------------
git checkout 2.1_rocm5.2
ln -sf /usr/sbin/cmake3 /root/linux/venv/bin/cmake
# 2.1 ends -----------------------

git submodule update --init --recursive

# used pytorch branches rocm_upgrade_CI_5.4 (2.0.0 - alpha)

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14

export ROCM_PATH=/opt/rocm
export PYTORCH_ROCM_ARCH="gfx803"   # Important for correct HIP target

export USE_CUDA=0
export USE_ROCM=1
export USE_MKLDNN=0
export USE_OPENMP=0
export USE_MPI=0
export USE_FBGEMM=0
export USE_CAFFE2=0
export USE_XNNPACK=0
export USE_KINETO=0
export USE_MAGMA=0
export ONEDNN_BUILD_OMP=OFF
export USE_ROCM_DEVICE_LIB=0
export USE_CAFFE2=0
export USE_ROCM=1
export USE_CUDA=0

export CMAKE_PREFIX_PATH="/opt/rocm;/opt/rocm/llvm"
export hip_DIR=/opt/rocm/hip/lib/cmake/hip

export PYTORCH_BUILD_VERSION=2.1
export PYTORCH_BUILD_NUMBER=0

#python setup.py install
CMAKE_COMMAND=cmake3 python setup.py bdist_wheel


