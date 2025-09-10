# Docker image name
IMG_NAME=edm_mbf_soleil

# parameters used at run-time (start_container.sh)
SSH_DOCKER_PORT=2222
CNTR_NAME=edm_mbf_soleil_cntr

# By default the following folder will be mounted in the docker container
# as `/mnt/shared`
#
# `MNT_FOLDER` is the path of the folder on the host machine
# the script `build_img/docker_files/mbf_edm/env_epics` is expecting to find `runopi` (from the DLS-MBF repository) at the location `/mnt/shared/mbf/runopi`
MNT_FOLDER=/home/docker_mbf_share
# MNT_MODE is either 'ro' or 'rw'
MNT_MODE=rw
