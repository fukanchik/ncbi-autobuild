#!/bin/bash -x

[ -z "$1" ] && exit 1

export PLATFORM=$1

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install subversion
sudo apt-get -y install build-essential
sudo apt-get -y install less
sudo apt-get -y install sed

. test.sh

