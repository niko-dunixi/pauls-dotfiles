#!/usr/bin/env zsh
function ssh-create-keys()
{
  if [ "${#}" -ne 2 ]; then
    # TODO https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
    echo "Only two arguments allowed, and it must be the identity-name and email respectively"
    return 1
  fi
  ssh_dir="${HOME}/.ssh/"
  if [ ! -f "${ssh_dir}/id_${1}" ]; then
    ssh-keygen -t rsa -b 4096 -C "${2}" -f "${ssh_dir}/id_${1}"
    eval "$(ssh-agent -s)"
    ssh-add -K "${ssh_dir}/id_${1}"
    return 0
  else
    echo "id_${1} already exists"
    return 1
  fi
}
