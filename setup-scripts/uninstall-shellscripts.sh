#!/usr/bin/env bash
set -e
current_directory=$(pwd)
root_directory="${current_directory%setup-scripts}"
installed_scripts_file="${root_directory}/installed-user-scripts.txt"
if [ ! -f "${installed_scripts_file}" ]; then
	echo "No scripts have been installed."
	exit 0
fi

echo "Uninstalling installed shellscripts"
cat "${installed_scripts_file}" | while read script_symlink; do
	if [ -L "${script_symlink}" ]; then
		rm -v "Unlinking: ${script_symlink}"
	else
		echo "Not symlinked, skipped: ${script_symlink}"
	fi
done

rm "${installed_scripts_file}"
