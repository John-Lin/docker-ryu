# Ryu SDN Framework
#
# Fork from https://registry.hub.docker.com/u/osrg/ryu/dockerfile/
# and https://registry.hub.docker.com/u/hsrnetwork/ryu/dockerfile/

FROM ubuntu:15.04

MAINTAINER John Lin <linton.tw@gmail.com>

# Download Ryu source code
RUN apt-get update && \
    apt-get install -qy --no-install-recommends python-setuptools python-pip \
        python-eventlet python-lxml python-msgpack unzip wget && \
    wget -O /opt/ryu.zip "http://github.com/osrg/ryu/archive/master.zip" --no-check-certificate && \
    wget -O /opt/ryu_dal.zip "https://github.com/TakeshiTseng/ryu-dynamic-loader/archive/master.zip" --no-check-certificate && \
    unzip -q /opt/ryu.zip -d /opt && \
    unzip -q /opt/ryu_dal.zip -d /opt && \
    mv /opt/ryu-master /opt/ryu && \
    cp /opt/ryu-dynamic-loader-master/dal_lib.py /opt/ryu/ryu/app && \
    cp /opt/ryu-dynamic-loader-master/dal_plugin.py /opt/ryu/ryu/app && \
    cd /opt/ryu && python ./setup.py install

ADD myapp /opt/ryu/ryu/app

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    /opt/ryu.zip

# 6633 - OpenFlow
# EXPOSE 6633

# Define working directory.
WORKDIR /opt/ryu

# Show ryu-manager version
# CMD ["./bin/ryu-manager", "--version"]
