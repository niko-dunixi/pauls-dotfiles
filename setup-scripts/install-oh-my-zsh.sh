#!/usr/bin/env bash
set -e

sudo chsh -s $(which zsh) "${USER}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

zshrc_file="${HOME}/.zshrc"
echo "Using .zshrc file: ${zshrc_file}"

cp "${zshrc_file}" "${zshrc_file}.bak"
echo "Setting default theme to 'af-magic'"
perl -0777pe 's/ZSH_THEME=".*?"/ZSH_THEME="af-magic"/s' "${zshrc_file}.bak" > "${zshrc_file}"
cp "${zshrc_file}" "${zshrc_file}.bak"
echo "Enabling plugins"
perl -0777pe 's/plugins=\(.*?\)/plugins=(git node mvn gradle ng npm python web-search yarn brew docker jira aws)/sg' "${zshrc_file}.bak" > "${zshrc_file}"

current_directory=$(pwd)
root_directory="${current_directory%setup-scripts}"
zsh_custom_directory="${root_directory}/zsh-custom/"

# cp "${zshrc_file}" "${zshrc_file}.bak"
# echo "Enabling custom directory"
# perl -0777pe "s/\\# ZSH_CUSTOM=.*?\b/ZSH_CUSTOM=\"${zsh_custom_directory}\"/s" "${zshrc_file}.bak" > "${zshrc_file}"
# cp "${zshrc_file}" "${zshrc_file}.bak"
# perl -0777pe "s/ZSH_CUSTOM=.*?\b/ZSH_CUSTOM=\"${zsh_custom_directory}\"/s" "${zshrc_file}.bak" > "${zshrc_file}"
# exit 1

rm "${zshrc_file}.bak"

echo "Sourcing ${zsh_custom_directory}/my-aliases-exports-etc.zsh to the end of the .zshrc file"
if ! grep -Fxq "source ${zsh_custom_directory}/my-aliases-exports-etc.zsh" "${zshrc_file}"; then
  echo "source ${zsh_custom_directory}/my-aliases-exports-etc.zsh" >> "${zshrc_file}"
fi
