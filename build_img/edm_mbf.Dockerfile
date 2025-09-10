# syntax=docker/dockerfile:1

FROM debian:jessie
WORKDIR /
COPY sources.list /etc/apt/sources.list
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -yq \
&& apt-get install openssh-server vim git \
libgif-dev libpng-dev libz-dev libmotif-dev libx11-dev libxp-dev libxmu-dev libxtst-dev libxpm-dev libreadline-dev \
xorg build-essential \
python-setuptools libpython-dev python-numpy \
 -yq --force-yes \
&& apt-get clean -y
RUN mkdir -p -m 0700 /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys
COPY docker_files/mbf_edm/env_epics /root/mbf_edm/

# COPY also creates the directory
# This weird line only copies extensions.tgz if the file exists
# if it does not exists, it will be downloaded by the script 'get_extensions_tgz.sh'
COPY docker_files/get_extensions_tgz.sh docker_files/extensions.tg[z] /root/mbf_edm/
COPY docker_files/extensions.patch /root/mbf_edm/myepics/
ARG EXTENSIONS_FNAME=/root/mbf_edm/extensions.tgz
RUN /root/mbf_edm/get_extensions_tgz.sh \
&& tar -C /root/mbf_edm/myepics -xf $EXTENSIONS_FNAME \
&& rm -f $EXTENSIONS_FNAME \
&& patch -d /root/mbf_edm/myepics/extensions -p1 -i ../extensions.patch \
&& rm -f /root/mbf_edm/myepics/extensions.patch

COPY docker_files/cothread-2.16-py2.7-linux-x86_64.egg /root/
COPY docker_files/make_epics_base.sh /root/mbf_edm/make_epics_base.sh
COPY docker_files/make_edm_dls.sh /root/mbf_edm/make_edm_dls.sh
RUN /root/mbf_edm/make_epics_base.sh \
&& /root/mbf_edm/make_edm_dls.sh \
&& rm -rf /root/mbf_edm/myepics

RUN apt-get install libxm4 libxp6 libgif4 -yq --force-yes \ 
&& apt-get remove --purge git vim \
libgif-dev libpng-dev libz-dev libmotif-dev libx11-dev libxp-dev \
libxmu-dev libxtst-dev libxpm-dev libreadline-dev \
build-essential python-setuptools libpython-dev curl -yq --force-yes \ 
&& apt-get --purge autoremove -yq --force-yes

COPY docker_files/mbf_edm/mbf_epics_opi /root/mbf_edm/

CMD ["bash"]
