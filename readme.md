# Run RISC-V debian linux using docker with vim development environment

This project builds a docker image with vim and other tools for RISC-V development.

The docker compose file is configured to mount the /workspace in the container along with your .vimrc and .vim directory.

## Install

Install docker and docker-compose

## Download

```bash
git clone drujensen/riscv-docker
```

## Build

```bash
docker-compose build
```

## Run

```bash
docker-compose run ubuntu bash
```

