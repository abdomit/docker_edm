#!/bin/bash

DOCKER_OPTS="--rm"
#DOCKER_OPTS=""

HERE_DIR=$(dirname -- "$( readlink -f -- "$0"; )";)
source $HERE_DIR/config.sh

if [ -z "$(docker images -q $IMG_NAME 2> /dev/null)" ]; then
    echo "Error: image '$IMG_NAME' does not exist"
    exit 1
fi

if [ ! "$(docker ps -aq -f name=$CNTR_NAME)" ]; then
    docker run $DOCKER_OPTS -itd --net=host --name $CNTR_NAME --volume=$MNT_FOLDER:/mnt/shared:$MNT_MODE $IMG_NAME
    echo "container created"
fi

if [ "$(docker ps -aq -f status=exited -f name=$CNTR_NAME)" ]; then
    docker start $CNTR_NAME
    echo "container started"
else
    echo "container already started"
fi

SED_OPTS="-e 's/^Port .*/Port $SSH_DOCKER_PORT/g' "
SED_OPTS+="-e 's/^AcceptEnv /AcceptEnv EPICS_* /g' "
CMD="sed -i $SED_OPTS /etc/ssh/sshd_config"
docker exec $CNTR_NAME sh -c "$CMD"
docker exec $CNTR_NAME sh -c "service ssh start"

