#!/usr/bin/env bash
set -e
SCRIPTS=( 'git-ignore-java' 'update-stuff' 'watch-poms' )
for i in "${SCRIPTS[@]}"; do
	if [ -L "/usr/local/bin/${i}" ]
	then
		echo "${i} already symlinked in /usr/local/bin/"
	else
		echo "Symlinking ${i} to /usr/local/bin/${i}"
		ln -s "./${i}" "/usr/local/bin/${i}"
		chmod +x "/usr/local/bin/${i}"
	fi
done
