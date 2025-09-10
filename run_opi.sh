#!/bin/bash

HERE_DIR=$(dirname -- "$( readlink -f -- "$0"; )";)

$HERE_DIR/ssh_cntr.sh /root/mbf_edm/mbf_epics_opi $1

if [ ! "$?" = 0 ]; then
    echo "Error during SSH. Is docker container started?"
fi
