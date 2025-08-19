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

# exits on any errors 
set -e

cd ~/linux

# source, dont do sh, we need exports
source ./00.environ.sh

# Setup
sh ./01.setup.sh

# ROCM platform
sh ./10.thunk.sh
sh ./11.core.sh
sh ./12.llvm.sh
sh ./13.clang-et-al.sh
sh ./14.cmake.sh
sh ./15.devicelibs.sh
sh ./16.rocrruntime.sh
sh ./17.rocminfo.sh
sh ./18.comgr.sh
sh ./19.opencl.sh

