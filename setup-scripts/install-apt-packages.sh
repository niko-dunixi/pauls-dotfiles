#!/usr/bin/env bash
set -e
# Update all the currently installed items
sudo apt update --fix-missing && sudo apt upgrade -y
# Install individual packages
install()
{
  sudo apt install -y "${@}"
}

install xclip
install git
install vim
install openjdk-8-jre maven gradle
install curl
# Kotlin
(
set -e
curl -s https://get.sdkman.io | bash
source "${HOME}/.sdkman/bin/sdkman-init.sh"
sdk install kotlin
)
install zsh terminator
# jenv
(
git clone https://github.com/gcuisinier/jenv.git "${HOME}/.jenv" || git --git-dir "${HOME}/.jenv/.git" pull
)
sudo apt autoremove -y
