FROM riscv64/ubuntu:22.04

RUN apt update -qq && apt install -y wget curl vim git build-essential cmake

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

WORKDIR /root

CMD ["/bin/bash"]
