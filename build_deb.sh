#!/bin/bash -x

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install svn
sudo apt-get install build-essential

. test.sh

