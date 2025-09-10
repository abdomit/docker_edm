#!/bin/bash

HERE_DIR=$(dirname -- "$( readlink -f -- "$0"; )";)
source $HERE_DIR/config.sh

# You can force EPICS to search for IOCs with the UDP broadcast method on a specific interface with the following environment variables
# IPs adresses in `EPICS_CA_ADDR_LIST` are the broadcast addresses of the VLANs where MBF crate are located
#export EPICS_CA_AUTO_ADDR_LIST=NO
#export EPICS_CA_ADDR_LIST="160.103.11.255 172.24.11.255"

# Or with pure TCP Ethernet, but the hostname of all MBF crates have to be specified
#export EPICS_CA_ADDR_LIST=
#export EPICS_CA_NAME_SERVERS="l-mbf-1 l-mbf-2"

SSH_OPTS=
#SSH_OPTS+='-o SendEnv=EPICS_* '
SSH_OPTS+='-o SendEnv=EPICS_CA_AUTO_ADDR_LIST '
SSH_OPTS+='-o SendEnv=EPICS_CA_ADDR_LIST '
SSH_OPTS+='-o StrictHostKeyChecking=no '
SSH_OPTS+='-o UserKnownHostsFile=/dev/null '
SSH_OPTS+='-o PubkeyAcceptedKeyTypes=+ssh-rsa'
ssh $SSH_OPTS -X -p $SSH_DOCKER_PORT root@localhost $*
