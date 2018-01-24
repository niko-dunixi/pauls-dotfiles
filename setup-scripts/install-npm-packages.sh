#!/usr/bin/env bash
set -e

function install_if_missing
{
  if npm list -g "${1}" @>/dev/null; then
    echo "${1} already installed"
  else
    echo ""
    echo "Installing ${1}"
    npm install -g "${1}"
  fi
}

echo ""
echo "Checking if NPM packages are installed is a costly"
echo "opperation, so this script is slow because of NPM"
echo ""

PACKAGES=( '@angular/cli' 'splash-cli' 'ungit' 'grunt' 'appium' )
for i in "${PACKAGES[@]}"; do
  install_if_missing "${i}"
done
