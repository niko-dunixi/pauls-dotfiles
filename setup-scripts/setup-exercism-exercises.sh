#!/usr/bin/env bash
echo "NOTE: Install git, exercism, and any submodule languages if you haven't already!"
echo "      See install-homebrew.sh and Brewfile to do this easily on OSX"

# Clone the project, if needed
exio_directory="${HOME}/exercism"
printf "\nUsing directory: ${exio_directory}\n"
if [ ! -d "${exio_directory}" ]; then
  git clone --recursive git@github.com:paul-nelson-baker/exercism-solutions.git "${exio_directory}"
elif [ ! -d "${exio_directory}/.git" ]; then
  echo "The exercism directory exists, but is NOT git controlled. Failing script because something is wrong."
  exit 1
else
  echo "Already cloned, proceeding..."
fi

# Update the submodules
(
cd "${exio_directory}"
./update-submodules.sh
)

# Done message
echo "Project has been downloaded and submodules have been recursively updated."

if [ ! -L "${HOME}/git/personal/exercism" ]; then
  mkdir -p "${HOME}/git/personal"
  ln -s "${exio_directory}" "${HOME}/git/personal/exercism"
fi
