#!/usr/bin/env bash
set -e

sudo chsh -s $(which zsh) "${USER}"
# Using forked version which enables silent install until the following issue has been merged
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Liquidsoul/oh-my-zsh/master/tools/install.sh) --silent || true"
