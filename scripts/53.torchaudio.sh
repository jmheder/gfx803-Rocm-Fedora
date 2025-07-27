############################################################
# Step. rocPRIMT
############################################################
cd ~/linux
#git clone -b release/2.1 https://github.com/pytorch/audio.git
cd audio

git submodule update --init --recursive

export CC=/usr/bin/gcc-14
export CXX=/usr/bin/g++-14


export USE_ROCM=0
export USE_CPU=1
export USE_CUDA=0

#export PYTORCH_BUILD_VERSION=2.1
#export PYTORCH_BUILD_NUMBER=0

#python setup.py install
CMAKE_COMMAND=cmake3 python setup.py bdist_wheel


