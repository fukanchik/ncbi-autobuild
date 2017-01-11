#!/bin/bash -x

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install svn
sudo apt-get -y install build-essential

. test.sh

