FROM riscv64/ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -qq && apt install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    vim \
    x11vnc \
    xvfb \
    && rm -rf /var/lib/apt/lists/*


# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# VNC password
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

WORKDIR /root

ENTRYPOINT x11vnc -forever -usepw -create & /bin/bash
