#!/usr/bin/env bash
set -e
SCRIPTS=( 'git-ignore-java' 'git-undelete' 'update-stuff' 'watch-poms' 'cls' 'mvn-get-sources' 'mvn-get-deps' 'loop-me' 'proxy-off' 'docker-clean' )
for i in "${SCRIPTS[@]}"; do
	if [ -L "/usr/local/bin/${i}" ]
	then
		echo "${i} already symlinked in /usr/local/bin/"
	else
		echo "Symlinking ${i} to /usr/local/bin/${i}"
		ln -s "$(pwd)/${i}" "/usr/local/bin/${i}"
		chmod +x "/usr/local/bin/${i}"
	fi
done
