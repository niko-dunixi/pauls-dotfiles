#!/usr/bin/env bash
set -e
current_directory=$(pwd)
root_directory="${current_directory%setup-scripts}"
echo "cd ${root_directory}/global-scripts"
cd "${root_directory}/global-scripts"
for i in *; do
	if [ -L "/usr/local/bin/${i}" ]
	then
		echo "${i} already symlinked in /usr/local/bin/"
	else
		echo "Symlinking ${i} to /usr/local/bin/${i}"
		ln -s "$(pwd)/${i}" "/usr/local/bin/${i}"
		chmod +x "/usr/local/bin/${i}"
    echo "/usr/local/bin/${i}" >> ../installed-user-scripts.txt
	fi
done
