# Run RISC-V debian linux using docker with vim development environment

This project builds a docker image with vim and other tools for RISC-V development.

Some of the tools pre-installed in the image are vim, gcc, ruby, python3, and rust.  I've also included a desktop environment with epiphany browser (only one I could find that supports riscv64).


## Install

Install Docker Desktop for Mac, Linux or Windows.

## Quick Start using Docker

You can use the pre-built image from docker hub.

```bash
docker run --platform linux/riscv64 -it -rm drujensen/riscv-ubuntu bash
```

## Using Docker Compose

```bash
git clone drujensen/riscv-docker
docker-compose build
docker-compose run ubuntu bash
```

## Support for VNC

The docker image supports VNC.

```bash
docker-compose up
```

You can connect to localhost:5900 with a VNC client.  The default password is `1234`.

## Volumes

The workspace directory has a volume mounted to `/workspace` in the container.  You can use this to share files between the host and the container.
