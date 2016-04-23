# Ryu SDN Framework

FROM ubuntu:16.04
# FROM ubuntu:15.10

MAINTAINER John Lin <linton.tw@gmail.com>

# Download Ryu source code and install
RUN apt-get update && apt-get install -qy --no-install-recommends
                        python-setuptools
                        python-pip \
                        python-eventlet \
                        python-lxml \
                        python-msgpack \
                        unzip \
                        wget \
                        curl \
                   && rm -rf /var/lib/apt/lists/*

RUN wget -O /opt/ryu.zip "http://github.com/osrg/ryu/archive/master.zip" --no-check-certificate && \
    unzip -q /opt/ryu.zip -d /opt && \
    mv /opt/ryu-master /opt/ryu && \
    cd /opt/ryu && pip install -r tools/pip-requires && \
    python setup.py install

# Clean up APT when done.
RUN apt-get clean &&  /opt/ryu.zip

# Define working directory.
WORKDIR /opt/ryu

# Show ryu-manager version
CMD ["./bin/ryu-manager", "--version"]
