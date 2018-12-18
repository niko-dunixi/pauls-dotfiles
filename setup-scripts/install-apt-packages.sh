#!/usr/bin/env bash
set -e
# Update all the currently installed items
sudo apt update --fix-missing && sudo apt upgrade -y
# Install individual packages
install()
{
  sudo apt install -y "${@}"
}

install vim curl gcc g++ make git xclip
install zsh terminator
install openjdk-8-jre maven gradle
# Kotlin
(
set -e
curl -s https://get.sdkman.io | bash
source "${HOME}/.sdkman/bin/sdkman-init.sh"
sdk install kotlin
)

# NodeJS v 10 is the latest LTS, as of 12/15/2018
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt update --fix-missing
install nodejs
if [ -f /usr/bin/nodejs ] && [ ! -f /usr/bin/node ]; then
  echo "Symlinking: ln -s /usr/bin/nodejs /usr/bin/node"
  sudo -H ln -s /usr/bin/nodejs /usr/bin/node
elif [ -L /usr/bin/node ]; then
  echo "Symlink already exists for: /usr/bin/node"
fi
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update --fix-missing
install yarn

# jenv
(
git clone https://github.com/gcuisinier/jenv.git "${HOME}/.jenv" || git --git-dir "${HOME}/.jenv/.git" pull
)
sudo apt autoremove -y
