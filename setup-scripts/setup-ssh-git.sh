#!/usr/bin/env bash
set -e

# make the directory if it doesn't exist
ssh_dir="${HOME}/.ssh"
chmod -R 700 ~/.ssh

function gen_ssh_key()
{
  ssh_file="${ssh_dir}/id_rsa_${1}"
  echo "Working: ${ssh_file}"
  if [ ! -f "${ssh_file}" ]; then
    ssh-keygen -t rsa -b 4096 -C "${2}" -f "${ssh_file}"
  else
    echo "${ssh_file} already exists"
  fi
  ssh-add -K "${ssh_file}"
}

# Startup the agent so we can add our keys (ssh-add)
eval "$(ssh-agent -s)"

gen_ssh_key wgu "paul.baker@wgu.edu"
gen_ssh_key github "paul.nelson.baker@gmail.com"
gen_ssh_key aws "paul.nelson.baker@gmail.com"
gen_ssh_key bitbucket "paul.nelson.baker@gmail.com"

# dump the config file into it. It has some nice things, like
# telling github to use ssh over https, because some coffee shops
# don't let me use the default ports sometimes.
cat >"${HOME}/.ssh/config" << EOSC
Host *
  UseKeychain yes
  User paul.baker
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa_wgu

Host github.com
  HostName ssh.github.com
  User git
  Port 443
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa_github

Host bitbucket.org
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa_bitbucket

Host ai-legacy
  HostName webapp-l249a.wgu.edu
EOSC

