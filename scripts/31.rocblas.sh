#! /usr/bin/bash

if [ -z "$ROCM_PATH" ]; then
  echo "Error: ROCM_PATH is not set."
  exit 1
fi

############################################################
# Step. rocfft
############################################################
cd ~/linux
git clone https://github.com/ROCmSoftwarePlatform/rocBLAS.git
cd rocBLAS
git checkout rocm-5.4.1

mkdir -p build-dir

export CC=/opt/rocm/bin/hipcc
export CXX=/opt/rocm/bin/hipcc

# ensure skip all target except from gfx803 
sed -i '113s|set_property( CACHE AMDGPU_TARGETS PROPERTY STRINGS .*|set_property( CACHE AMDGPU_TARGETS PROPERTY STRINGS all gfx803)|' ~/linux/rocBLAS/CMakeLists.txt
sed -i '119s|TARGETS .*|TARGETS gfx803|' ~/linux/rocBLAS/CMakeLists.txt

cmake -S . -B build-dir \
  -DCMAKE_INSTALL_PREFIX=$ROCM_PATH \
  -DPYTHON_EXECUTABLE=/usr/bin/python3.10 \
  -DPYTHON_executable=/usr/bin/python3.10 \
  -DBUILD_WITH_HIPBLASLT=OFF \
  -DCMAKE_BUILD_TYPE=$RELEASE_TYPE \
  -DAMDGPU_TARGETS=$GPU_REV \
  -DBUILD_WITH_TENSILE=ON \
  -DTensile_LIBRARY_FORMAT=msgpack \
  -DTensile_LOGIC=asm_full \
  -DTensile_CODE_OBJECT_VERSION=V3 \
  -DTensile_ARCHITECTURE=gfx803 \
  -DTensile_COMPILER=hipcc \
  -DTensile_STATIC_LIB=ON \
  -DBUILD_CLIENTS=OFF

# compile
cmake --build build-dir -j$JOBS

# install
cmake --install build-dir
