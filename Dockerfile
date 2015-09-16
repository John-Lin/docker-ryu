# Ryu SDN Framework
#
# Fork from https://registry.hub.docker.com/u/osrg/ryu/dockerfile/
# and https://registry.hub.docker.com/u/hsrnetwork/ryu/dockerfile/

FROM ubuntu:15.04

MAINTAINER John Lin <linton.tw@gmail.com>

# Download Ryu source code and install
RUN apt-get update && \
    apt-get install -qy --no-install-recommends python-setuptools python-pip \
        python-eventlet python-lxml python-msgpack python-networkx unzip wget curl && \
    wget -O /opt/ryu.zip "http://github.com/osrg/ryu/archive/master.zip" --no-check-certificate && \
    # wget -O /opt/ryu_dal.zip "https://github.com/TakeshiTseng/ryu-dynamic-loader/archive/master.zip" --no-check-certificate && \
    unzip -q /opt/ryu.zip -d /opt && \
    # unzip -q /opt/ryu_dal.zip -d /opt && \
    mv /opt/ryu-master /opt/ryu && \
    # cp /opt/ryu-dynamic-loader-master/dal_lib.py /opt/ryu/ryu/app && \
    # cp /opt/ryu-dynamic-loader-master/dal_plugin.py /opt/ryu/ryu/app && \
    cd /opt/ryu && python ./setup.py install && \
    pip install -U routes webob oslo.config


# Node.js 4.x Installation
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get install -y nodejs && \
    wget -O /opt/remote-ryu.zip "https://github.com/John-Lin/remote-ryu/archive/master.zip" --no-check-certificate && \
    unzip -q /opt/remote-ryu.zip -d /opt && \
    mv /opt/remote-ryu-master /opt/ryu && \
    cd /opt/ryu/remote-ryu-master && npm install

ADD myapp /opt/ryu/ryu/app

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    /opt/ryu.zip /opt/remote-ryu.zip

# 6633 - OpenFlow
# EXPOSE 6633

# Define working directory.
WORKDIR /opt/ryu

# Show ryu-manager version
# CMD ["./bin/ryu-manager", "--version"]

CMD ["node", "./remote-ryu-master/remote-ryu.js"]
