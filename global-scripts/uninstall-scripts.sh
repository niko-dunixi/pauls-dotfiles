#!/usr/bin/env bash
set -e
SCRIPTS=( 'git-ignore-java' 'update-stuff' 'watch-poms' 'cls' 'mvn-get-sources' 'mvn-get-deps' 'loop-me' )
for i in "${SCRIPTS[@]}"; do
	if [ -L "/usr/local/bin/${i}" ]
	then
		rm -v "/usr/local/bin/${i}"
	else
		echo "Isn't linked, skipping /usr/local/bin/${i}"
	fi
done
