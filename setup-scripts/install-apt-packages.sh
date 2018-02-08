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

sudo apt-get autoremove -y
