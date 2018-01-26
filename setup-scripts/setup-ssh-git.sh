#!/usr/bin/env bash
set -e

# make the directory if it doesn't exist
ssh_dir="${HOME}/.ssh"

if [ ! -f "${ssh_dir}/id_rsa_wgu" ]; then
  ssh-keygen -t rsa -b 4096 -C "paul.baker@wgu.edu" -f "${ssh_dir}/id_rsa_wgu"
else
  echo "id_rsa_wgu already exists"
fi
if [ ! -f "${ssh_dir}/id_rsa_github" ]; then
  ssh-keygen -t rsa -b 4096 -C "paul.nelson.baker@gmail.com" -f "${ssh_dir}/id_rsa_github"
else
  echo "id_rsa_github already exists"
fi

# dump the config file into it. It has some nice things, like
# telling github to use ssh over https, because some coffee shops
# don't let me use the default ports sometimes.
cat >"${HOME}/.ssh/config" << EOSC
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa_wgu

Host checkit-dev
  UseKeychain yes
  AddKeysToAgent yes
  Hostname 172.27.14.88
  IdentityFile ~/.ssh/id_rsa_wgu

Host github.com
  HostName ssh.github.com
  User git
  Port 443
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa_github

Host mac-build-server
  Hostname 10.50.7.91
  IdentityFile ~/.ssh/id_rsa_wgu
EOSC

# Now we need to add our keys to the keychain
eval "$(ssh-agent -s)"
ssh-add -K "${ssh_dir}/id_rsa_wgu"
ssh-add -K "${ssh_dir}/id_rsa_github"
ssh-copy-id -i "${ssh_dir}/id_rsa_wgu" mac-build-server
