#! /usr/bin/env bash

echo "Building NCBI C++ Toolkit from anonsvn"
echo "$((lsb_release -a))"
echo "$((hostname))"

ls

svn co http://anonsvn.ncbi.nlm.nih.gov/repos/v1/trunk/c++ toolkit-svn

ls

cd  toolkit-svn

svn info .

ls

./compilers/unix/GCC.sh --with-flat-makefile

ls

(cd *-DebugMT64/ && ls && cd build && COLOR_DIAGNOSTICS=" " /usr/bin/make -f Makefile.flat -j 2 ; echo y | /usr/bin/make check_r)

ls

