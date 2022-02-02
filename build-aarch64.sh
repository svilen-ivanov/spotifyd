#!/bin/bash
set -xeuo pipefail
export DEBIAN_FRONTEND=noninteractive

cd /root/spotifyd
dpkg --add-architecture arm64
sed 's/deb http/deb \[arch=amd64\] http/' -i /etc/apt/sources.list
cat >/etc/apt/sources.list.d/arm64.list <<EOF
deb [arch=arm64] http://bg.ports.ubuntu.com/ focal main universe restricted multiverse
deb [arch=arm64] http://bg.ports.ubuntu.com/ focal-updates main universe restricted multiverse
deb [arch=arm64] http://bg.ports.ubuntu.com/ focal-security main universe restricted multiverse
EOF
apt -y update
apt -y install \
  build-essential \
  curl \
  pkg-config \
  pkg-config-aarch64-linux-gnu \
  gcc-aarch64-linux-gnu \
  libasound2-dev:arm64 \
  libssl-dev:arm64 \
  libpulse0:arm64
apt -y remove rustc
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME"/.cargo/env
rustup target add aarch64-unknown-linux-gnu
export RUSTFLAGS="-C linker=aarch64-linux-gnu-gcc"
export PKG_CONFIG_PATH=/usr/lib/aarch64-linux-gnu/pkgconfig
export PKG_CONFIG_ALLOW_CROSS=1
cargo build --target=aarch64-unknown-linux-gnu --release --features "pulseaudio_backend"
/usr/aarch64-linux-gnu/bin/strip target/aarch64-unknown-linux-gnu/release/spotifyd
echo "---- DONE ----"
echo "docker cp spotifyd-aarch64:/root/spotifyd/target/aarch64-unknown-linux-gnu/release/spotifyd ."
sleep infinity
