#!/bin/bash

HERE_DIR=$(dirname -- "$( readlink -f -- "$0"; )";)
cd $HERE_DIR

# extract only variable INSTALL_DIR from, env_epics
eval $(source $HERE_DIR/env_epics ; echo "INSTALL_DIR=$INSTALL_DIR")

easy_install /root/cothread-2.16-py2.7-linux-x86_64.egg
rm -f /root/cothread-2.16-py2.7-linux-x86_64.egg

mkdir -p myepics
cd myepics

export LC_PAPER=C
export LANG=C
export EPICS_HOST_ARCH=linux-x86_64
export EPICS_BASE=$PWD/base
export EPICS_EXTENSIONS=$PWD/extensions

(cd extensions ; make)

# Changing installation directory does not work during the first make,
# but changing the installation directory, and running make a second time,
# is working for some obsure reasons (need to be done for both 
# epics and extensions)

cd $HERE_DIR/myepics

CONFIG_FILE=$EPICS_BASE/configure/CONFIG_SITE
sed -i "s|#INSTALL_LOCATION=.*|INSTALL_LOCATION=$INSTALL_DIR|g" $CONFIG_FILE
(cd base ; make)

CONFIG_FILE=$EPICS_EXTENSIONS/configure/RELEASE
export EPICS_BASE=$INSTALL_DIR
export EPICS_EXTENSIONS=$INSTALL_DIR
sed -i "s|#INSTALL_LOCATION_EXTENSIONS=.*|INSTALL_LOCATION_EXTENSIONS=$INSTALL_DIR|g" $CONFIG_FILE
# This one does not realised it has to be updated...
(cd extensions/src/edm/setup ; make clean)
(cd extensions ; make)
