#!/usr/bin/env bash
set -e
current_directory=$(pwd)
root_directory="${current_directory%setup-scripts}"
echo "cd ${root_directory}/global-scripts"
cd "${root_directory}/global-scripts"
for i in *; do
	destination="/usr/local/bin/${i}"
	if [ -L "${destination}" ]; then
		echo "Removing $(rm -v "${destination}")... (will re-link)"
	fi
	echo "Symlinking ${i} to ${destination}"
	ln -s "$(pwd)/${i}" "${destination}"
	chmod +x "${destination}"
	echo "${destination}" >> ../installed-user-scripts.txt
done
