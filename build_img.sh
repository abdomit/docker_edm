#!/bin/bash

HERE_DIR=$(dirname -- "$( readlink -f -- "$0"; )";)
source $HERE_DIR/config.sh

cd build_img
docker build -t $IMG_NAME -f edm_mbf.Dockerfile .
