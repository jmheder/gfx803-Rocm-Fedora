#! /usr/bin/bash

######################################################################
# Build on Fedora 42
# Run this as root 
######################################################################

echo ""
echo ""
echo "**********************************************************************"
echo "Compiling minimalistic ROCM platform (gfx803) on Fedora for pytorch "
echo "For Ubuntu please checkout github.com/xuhuisheng/rocm-build/ "
echo ""
echo "Aim ROCM version 5.4.1 and pytorch version 1.13"
echo "I'm working on upgrading to ROCM version 5.4.3 and PYTORCH 2.0"
echo "**********************************************************************"
echo ""
echo ""
echo "**********************************************************************"
echo "This will take some time .. if you encouter issues you can also "
echo "execute each script one by one, first execute 'source ./00_environm.sh'"
echo "and then execte each script one by one"
echo "**********************************************************************"
echo ""


mkdir -p ~/linux
cd ~/linux

# source, dont do sh, we need exports
source ./00.environ.sh

# Setup
#sh ./01.setup.sh

# ROCM platform
#sh ./10.thunk.sh
#sh ./11.core.sh
#sh ./12.llvm.sh
#sh ./13.clang-et-al.sh
#sh ./14.cmake.sh
#sh ./15.devicelibs.sh
#sh ./16.rocrruntime.sh
#sh ./17.rocminfo.sh
#sh ./18.comgr.sh
#sh ./19.opencl.sh
#sh ./20.hipcc.sh

# Libraries
#sh ./30.rocfft.sh
#sh ./31.rocblas.sh
#sh ./32.rocprim.sh
#sh ./33.rocsolver.sh
#sh ./34.hipsparse.sh
#sh ./35.rocrand.sh
#sh ./37.hipfft.sh
#sh ./38.hipblas.sh
#sh ./39.half.sh
#sh ./40.composable.sh  <-- try to get this into the build, it's from 5.7.x
#sh ./41.miopen.sh
#sh ./42.hipCUB.sh
#sh ./43.rocThrust.sh
#sh ./44.rocm-smi.sh
#sh NOT DONE ./45.roctracer.sh # issue with -FPIE 

# missing file 
#ln -sf /opt/rocm/.info/version /opt/rocm/.info/version-dev

# Applications

#pytorch 
#sh 50 ./44.pytorch.sh
