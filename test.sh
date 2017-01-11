#! /usr/bin/env bash
svn co http://anonsvn.ncbi.nlm.nih.gov/repos/v1/trunk/c++ toolkit-svn
cd  toolkit-svn
./compilers/unix/GCC.sh --with-flat-makefile

