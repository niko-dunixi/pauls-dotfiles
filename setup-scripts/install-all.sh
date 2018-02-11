#!/usr/bin/env bash
set -e

echo "I need sudo to install some stuff and manipulate the shell. Gimmie gimmie gimmie!"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

current_directory="$(pwd)"
root_directory="${current_directory%setup-scripts}"
setup_scripts_directory="${root_directory}/setup-scripts/"
cd "${setup_scripts_directory}"

my_os="$(uname)"

if [ "${my_os}" == "darwin" ]; then
  ./install-homebrew-packages.sh
else
  ./install-apt-packages.sh
fi
./setup-java.sh
./install-npm-packages.sh
./install-shellscripts.sh
./install-oh-my-zsh.sh
./setup-git-commit-message.sh
./setup-ssh-git.sh
