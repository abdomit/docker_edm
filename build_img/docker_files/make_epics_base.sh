#!/bin/bash

HERE_DIR=$(dirname -- "$( readlink -f -- "$0"; )";)

# extract only variable INSTALL_DIR from, env_epics
eval $(source $HERE_DIR/env_epics ; echo "INSTALL_DIR=$INSTALL_DIR")

mkdir -p $HERE_DIR/myepics
cd $HERE_DIR/myepics

export LC_PAPER=C
export LANG=C
export EPICS_HOST_ARCH=linux-x86_64
export EPICS_BASE=$PWD/base

git clone -b 3.14 https://github.com/epics-base/epics-base.git base
(cd base ; make)

