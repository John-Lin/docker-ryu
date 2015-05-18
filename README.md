# docker-ryu

RYU in Docker

### Usage

Run the container and login (Docker port forwards port 6633 to host port 6633)
```
docker run -it -p 6633:6633 --rm linton/docker-ryu ./bin/ryu-manager /bin/bash
```

or run the specific app `simple_switch_13`
```
docker run -it -p 6633:6633 --rm linton/docker-ryu ./bin/ryu-manager ryu/app/simple_switch_13.py
```
