# Docker image for EDM (EPICS GUI)

## Instructions

In order to generate the docker image, please follow these steps:

1/ Add your ssh public key(s) to `build_img/authorized_keys`

2/ Update the file `config.sh` with your own parameters

3/ Make sure to have cloned the DLS-MBF repository in the folder mounted in the docker container, as defined in `config.sh`. You may need to run `make` in the DLS-MBF forder to generate all OPI files.

3/ Build the docker image by running the script `build_img.sh`

4/ Start the docker container with the script `start_container.sh`

5/ You may want to customise the script `ssh_cntr.sh` to configure EPICS environment variables

6/ Check you can connect the container with ssh by running `ssh_cntr.sh`

7/ Run the MBF OPI using the script `run_opi.sh`. This script expect one argument: the prefix of the MBF PVs (for instance 'SR-TMBF' used at the ESRF).
