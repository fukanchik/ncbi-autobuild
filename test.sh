#! /usr/bin/env bash

set -x
set -e


[ -z "$PLATFORM" ] && PLATFORM='GCC.sh --with-flat-makefile'
export PLATFORM

echo "Building NCBI C++ Toolkit from anonsvn"
echo "LANG=$LANG"
echo "LC_ALL=$LC_ALL"
echo "$((lsb_release -a))"
echo "$((hostname))"
echo "PLATFORM=${PLATFORM}"

ls

svn co https://anonsvn.ncbi.nlm.nih.gov/repos/v1/trunk/c++ toolkit-svn

ls

cd  toolkit-svn

svn info .

ls

export CCACHE_DIR=/tmp/ccache
export CCACHE_DISABLE=1

./compilers/unix/GCC.sh --with-flat-makefile --with-projects=scripts/projects/connect.lst

ls

(cd *-DebugMT64/ && ls && cd build && COLOR_DIAGNOSTICS=" " /usr/bin/make -f Makefile.flat -j 16 ; echo y | /usr/bin/make check_r)

ls

