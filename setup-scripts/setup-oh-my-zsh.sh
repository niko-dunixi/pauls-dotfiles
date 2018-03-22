#!/usr/bin/env bash

ohmyzsh_rc="${HOME}/.zshrc"
ohmyzsh_custom_directory="${HOME}/.oh-my-zsh/custom"

# Link our custom stuff
current_directory=$(pwd)
root_directory="${current_directory%setup-scripts}"
custom_from_install_directory="${root_directory}/zsh-custom/"
for source in ${custom_from_install_directory}/*.zsh; do
  destination="${ohmyzsh_custom_directory}/$(basename ${source})"
  if [ -L "${destination}" ]; then
    echo "Unlinking: $(rm -v "${destination}")"
  fi
  echo ln -s "${source}" "${destination}"
  ln -s "${source}" "${destination}"
done

# Make changes to the zshrc file so we have our theme and plugins set
export ohmyzsh_rc
python3 - << END
import os
import re

# Load the zshrc file
ohmyzsh_rc = os.getenv('ohmyzsh_rc')
print('Loading', ohmyzsh_rc)
with open(ohmyzsh_rc, 'r') as file:
    file_data = file.read()

print('Setting theme')
file_data = re.sub(r"^ZSH_THEME=\".*?\"", 'ZSH_THEME="af-magic"', file_data, flags=re.MULTILINE)
# Set the plugins we want
print('Setting plugins')
file_data = re.sub(r"^plugins=\(.*?\)",
                  'plugins=(git node mvn gradle ng npm python web-search yarn brew docker jira aws)',
                   file_data, flags=re.MULTILINE | re.DOTALL)

print('Setting contents back for', ohmyzsh_rc)
# Save the contents back to the zshrc file
with open(ohmyzsh_rc, 'w') as file:
    file.write(file_data)
END
