FROM riscv64/ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -qq && apt install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    git \
    curl \
    wget \
    vim \
    xvfb \
    x11vnc \
    xfce4 \
    xfce4-goodies \
    at-spi2-core \
    dbus-x11 \
    net-tools \
    x11-utils \
    software-properties-common \
    dirmngr \
    apt-transport-https \
    lsb-release \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# Install Ruby
RUN apt update -qq && apt install -y --no-install-recommends \
    ruby-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python3
RUN apt update -qq && apt install -y --no-install-recommends \
    python3-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN echo "export PATH=$PATH:/root/.cargo/bin" >> ~/.bashrc

# Install Node.js (not yet supported)
# RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
# RUN apt-get install -y nodejs

# VNC server
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd
RUN echo "xfce4-session" > ~/.xinitrc
RUN chmod +x ~/.xinitrc

# Setup development environment
COPY bashrc /root/.bashrc
COPY vimrc /root/.vimrc
COPY vim /root/.vim

EXPOSE 5900

CMD ["x11vnc", "-repeat", "-forever", "-usepw", "-create"]
