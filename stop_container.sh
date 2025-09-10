#!/bin/bash

HERE_DIR=$(dirname -- "$( readlink -f -- "$0"; )";)
source $HERE_DIR/config.sh

if [ ! "$(docker ps -aq -f name=$CNTR_NAME)" ]; then
    echo "container does not exist"
    exit 1
fi

if [ ! "$(docker ps -aq -f status=exited -f name=$CNTR_NAME)" ]; then
    docker stop $CNTR_NAME
    echo "container stopped"
else
    echo "container already stopped"
fi

