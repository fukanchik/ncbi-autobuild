#!/bin/bash -x

[ -z "$1" ] && exit 1

export PLATFORM=$1

apt-get -y update
apt-get -y upgrade
apt-get -y install subversion
apt-get -y install build-essential
apt-get -y install less
apt-get -y install sed

. test.sh

