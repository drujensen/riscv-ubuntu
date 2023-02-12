# Run RISC-V Ubuntu using Docker or Docker Compose

This project provides a docker image with tools for RISC-V development.

Some of the languages pre-installed on the image are gcc, go, rust, java, python, nodejs and ruby.  

I've also included a desktop environment xfce and epiphany browser (only one I could find that supports riscv64).

## Install

Install Docker Desktop for Mac, Linux or Windows.

## Quick Start using Docker

You can use the pre-built image from docker hub.

```bash
docker run --platform linux/riscv64 -it drujensen/riscv-ubuntu bash
```

## Support for VNC

The docker image supports VNC.

```bash
docker run --platform linux/riscv64 -it drujensen/riscv-ubuntu
```

You can connect to `vnc://localhost:5900` with a VNC client.  The default password is `1234`.

## Using Docker Compose

The docker-compose.yml file is included in the project.  You can use it to build the image and run the container.

```bash
git clone https://github.com/drujensen/riscv-ubuntu.git
docker-compose build
docker-compose up
```

### Volumes

The workspace directory has a volume mounted to `/workspace` in the container.  You can use this to share files between the host and the container.

I have also included my .vimrc file in the project. It has my favorite vim settings. Change this to your own preferences.
