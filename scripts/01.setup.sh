#! /usr/bin/bash

# This will remove all rocm packages, don't mix platforms, old scripts and broken userland will screw everything up
dnf remove rocm* hip*

# Too many dependencies, not sure if this is all ?
dnf install -y gcc gcc-c++ gcc-gfortran make cmake ninja-build kernel-devel kernel-headers git  python3 python3-devel python3-pip python3-setuptools   libstdc++-devel llvm llvm-devel clang clang-devel   libedit-devel ncurses-devel zlib-devel libffi-devel perl perl-devel perl-ExtUtils-MakeMaker openssl-devel wget tar bzip2 elfutils-libelf-devel libtool autoconf automake libxml2-devel openexr-devel boost-static

