#!/usr/bin/env bash
set -e
# non-interactive Rust installation
curl https://sh.rustup.rs -sSf | sh -s -- -y
# Need to source the file so this install script can add additional packages
source $HOME/.cargo/env

function cargo_install()
{
  cargo install "${@}" || echo "Failed to install '${@}', it may already be installed."
}

# Install rust centric stuff
cargo_install ripgrep
