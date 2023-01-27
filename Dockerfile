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
    xfce4 \
    xfce4-goodies \
    && rm -rf /var/lib/apt/lists/*


# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN echo "export PATH=$PATH:/root/.cargo/bin" >> ~/.bashrc

# VNC password
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd
RUN echo "unset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec /usr/bin/startxfce4" > ~/.vnc/xstartup
RUN echo "geometry=1920x1080\ndpi=96" > ~/.vnc/config
RUN chmod +x ~/.vnc/xstartup

WORKDIR /root

EXPOSE 5900

CMD ["x11vnc", "-forever", "-usepw", "-create"] 
