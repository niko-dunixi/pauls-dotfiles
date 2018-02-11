#!/usr/bin/env bash
set -e
# Update all the currently installed items
sudo apt-get update && sudo apt-get upgrade -y
# Install individual packages
install()
{
  sudo apt-get install -y "${@}"
}

install xclip
install git
install vim
install openjdk-8-jre maven gradle
install curl
(
set -e
curl -s https://get.sdkman.io | bash
source "/home/paulbaker/.sdkman/bin/sdkman-init.sh"
sdk install kotlin
)
install zsh terminator

sudo apt-get autoremove -y
