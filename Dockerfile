# Ryu SDN Framework
FROM ubuntu:16.04
# FROM ubuntu:14.04.4

MAINTAINER John Lin <linton.tw@gmail.com>

ENV HOME /root
# Define working directory.
WORKDIR /root

# Download Ryu source code and install
RUN apt-get update && \
    apt-get install -qy --no-install-recommends python-setuptools python-pip \
        python-eventlet python-lxml python-msgpack curl && \
    rm -rf /var/lib/apt/lists/* && \
    curl -kL https://github.com/osrg/ryu/archive/master.tar.gz | tar -xvz && \
    mv ryu-master ryu && \
    pip install -U pip && \
    cd ryu && pip install -r tools/pip-requires && \
    python ./setup.py install

# Show ryu-manager version
CMD ["./bin/ryu-manager", "--version"]
