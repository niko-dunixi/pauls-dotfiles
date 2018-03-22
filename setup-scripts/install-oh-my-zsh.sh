#!/usr/bin/env bash
set -e

ohmyzsh_custom_directory="${HOME}/.oh-my-zsh/custom"

sudo chsh -s $(which zsh) "${USER}"
# Using forked version which enables silent install until the following issue has been merged
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Liquidsoul/oh-my-zsh/master/tools/install.sh) --silent"

#zshrc_file="${HOME}/.zshrc"
#printf "\nUsing .zshrc file: ${zshrc_file}\n"

#cp "${zshrc_file}" "${zshrc_file}.bak"
#echo "Setting default theme to 'af-magic'"
#perl -0777pe 's/ZSH_THEME=".*?"/ZSH_THEME="af-magic"/s' "${zshrc_file}.bak" > "${zshrc_file}"
#cp "${zshrc_file}" "${zshrc_file}.bak"
#echo "Enabling plugins"
#perl -0777pe 's/plugins=\(.*?\)/plugins=(git node mvn gradle ng npm python web-search yarn brew docker jira aws)/sg' "${zshrc_file}.bak" > "${zshrc_file}"
#
current_directory=$(pwd)
root_directory="${current_directory%setup-scripts}"
custom_from_install_directory="${root_directory}/zsh-custom/"

for i in "${custom_from_install_directory}/*.zsh"; do
  if [ -L "${i}" ]; then
    ln -s "${i}" "${ohmyzsh_custom_directory}/$(basename ${i})"
  fi
done

# cp "${zshrc_file}" "${zshrc_file}.bak"
# echo "Enabling custom directory"
# perl -0777pe "s/\\# ZSH_CUSTOM=.*?\b/ZSH_CUSTOM=\"${zsh_custom_directory}\"/s" "${zshrc_file}.bak" > "${zshrc_file}"
# cp "${zshrc_file}" "${zshrc_file}.bak"
# perl -0777pe "s/ZSH_CUSTOM=.*?\b/ZSH_CUSTOM=\"${zsh_custom_directory}\"/s" "${zshrc_file}.bak" > "${zshrc_file}"
# exit 1

#rm "${zshrc_file}.bak"
#echo "Sourcing ${zsh_custom_directory}/my-aliases-exports-etc.zsh to the end of the .zshrc file"
#if ! grep -Fxq "source ${zsh_custom_directory}/my-aliases-exports-etc.zsh" "${zshrc_file}"; then
#  echo "source ${zsh_custom_directory}/my-aliases-exports-etc.zsh" >> "${zshrc_file}"
#fi
