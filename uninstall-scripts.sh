#!/usr/bin/env bash
set -e
SCRIPTS=( 'git-ignore-java' 'update-stuff' 'watch-poms' )
for i in "${SCRIPTS[@]}"; do
	if [ -L "/usr/local/bin/${i}" ]
	then
		# echo "${i} already symlinked in /usr/local/bin/"
		rm -v "/usr/local/bin/${i}"
	else
		echo "Isn't linked, skipping /usr/local/bin/${i}"
	fi
done
