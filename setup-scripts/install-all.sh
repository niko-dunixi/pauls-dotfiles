#!/usr/bin/env bash
set -e

current_directory="$(pwd)"
root_directory="${current_directory%setup-scripts}"
setup_scripts_directory="${root_directory}/setup-scripts/"
cd "${setup_scripts_directory}"

./install-homebrew.sh
./setup-java.sh
./install-npm-packages.sh
./install-shellscripts.sh
./install-oh-my-zsh.sh
./setup-git-commit-message.sh
