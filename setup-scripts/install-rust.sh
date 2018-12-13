#!/usr/bin/env bash
set -e
# non-interactive Rust installation
curl https://sh.rustup.rs -sSf | sh -s -- -y
# Need to source the file so this install script can add additional packages
source $HOME/.cargo/env
# Install rust centric stuff
cargo install ripgrep # We COULD install with brew, but we miss out on SIMD
