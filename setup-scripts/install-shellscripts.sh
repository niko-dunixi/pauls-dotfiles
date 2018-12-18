#!/usr/bin/env bash
set -e
current_directory=$(pwd)
root_directory="${current_directory%setup-scripts}"
echo "cd ${root_directory}/global-scripts"
cd "${root_directory}/global-scripts"
for i in *; do
	destination="/usr/local/bin/${i}"
	if [ -L "${destination}" ]; then
		sudo -H unlink "${destination}"
		echo "Removing ${destionation}... (will re-link)"
	fi
	echo "Symlinking ${i} to ${destination}"
	sudo -H ln -s "$(pwd)/${i}" "${destination}"
	sudo -H chmod +x "${destination}"
	echo "${destination}" >> ../installed-user-scripts.txt
done
