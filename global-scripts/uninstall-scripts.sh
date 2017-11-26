#!/usr/bin/env bash
set -e
SCRIPTS=( 'git-ignore-java' 'git-undelete' 'update-stuff' 'watch-poms' 'cls' 'mvn-get-sources' 'mvn-get-deps' 'mvn-install-as' 'loop-me' 'proxy-off' 'docker-clean' 'grep-java' 'github-fix-email' )
for i in "${SCRIPTS[@]}"; do
	if [ -L "/usr/local/bin/${i}" ]
	then
		rm -v "/usr/local/bin/${i}"
	else
		echo "Isn't linked, skipping /usr/local/bin/${i}"
	fi
done
