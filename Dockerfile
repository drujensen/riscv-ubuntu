FROM riscv64/ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

RUN apt update -qq && apt install -y --no-install-recommends \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    lsb-release \
    net-tools \
    dirmngr \
    gnupg \
    git \
    curl \
    wget \
    file \
    unzip \
    zip \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install C/C++
RUN apt update -qq && apt install -y --no-install-recommends \
    build-essential \
    cmake \
    autoconf \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

# Install Go
RUN wget http://ftp.ports.debian.org/debian-ports/pool/main/g/golang-1.19/golang-1.19-src_1.19.5-1_all.deb && \
    dpkg -i golang-1.19-src_1.19.5-1_all.deb && \
    rm golang-1.19-src_1.19.5-1_all.deb
RUN wget http://ftp.ports.debian.org/debian-ports/pool-riscv64/main/g/golang-1.19/golang-1.19-go_1.19.5-1_riscv64.deb && \
    dpkg -i golang-1.19-go_1.19.5-1_riscv64.deb && \
    rm golang-1.19-go_1.19.5-1_riscv64.deb

# OpenJDK 17 is interpretor only
RUN apt update -qq && apt install -y --no-install-recommends \
    openjdk-19-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN apt update -qq && apt install -y --no-install-recommends \
    ruby-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python3
RUN apt update -qq && apt install -y --no-install-recommends \
    python3-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN wget https://github.com/v8-riscv/node/releases/download/v14.8.0-riscv64/node-v14.8.0-linux-riscv64.tar.xz && \
    tar -C /usr/local -xJf node-v14.8.0-linux-riscv64.tar.xz && \
    rm node-v14.8.0-linux-riscv64.tar.xz

# PATH
RUN echo "export PATH=$PATH:/root/.cargo/bin:/usr/lib/go-1.19/bin:/usr/local/node-v14.8.0-linux-riscv64/bin:/usr/lib/jvm/current" >> ~/.bashrc

# Install xvfb
RUN apt update -qq && apt install -y --no-install-recommends \
    xvfb \
    x11vnc \
    xfce4 \
    xfce4-goodies \
    at-spi2-core \
    dbus-x11 \
    x11-utils \
    epiphany-browser \
    && rm -rf /var/lib/apt/lists/*

# VNC server
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd
RUN echo "xfce4-session" > ~/.xinitrc
RUN chmod +x ~/.xinitrc

# Setup development environment
COPY vimrc /root/.vimrc
COPY vim /root/.vim

EXPOSE 5900

CMD ["x11vnc", "-repeat", "-forever", "-usepw", "-create"]
