#! /usr/bin/env bash

ls

svn co http://anonsvn.ncbi.nlm.nih.gov/repos/v1/trunk/c++ toolkit-svn

ls

cd  toolkit-svn

ls

./compilers/unix/GCC.sh --with-flat-makefile

ls

(cd "*-DebugMT64/build" && /usr/bin/make -f Makefile.flat)

ls
