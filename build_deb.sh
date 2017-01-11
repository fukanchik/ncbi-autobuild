#!/bin/bash -x

[ -z "$1" ] && exit 1

export PLATFORM=$1

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install subversion
sudo apt-get -y install build-essential

. test.sh

