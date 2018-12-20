#!/usr/bin/env bash
set -e

function install_if_missing
{
  if npm list -g "${1}" @>/dev/null; then
    echo "${1} already installed"
  else
    echo ""
    echo "Installing ${1}"
    command="npm install -g ${1}"
    echo "Running: ${command}"
    $command || echo "Failed to run: ${command}"
  fi
}

PACKAGES=( 'npx' )
for i in "${PACKAGES[@]}"; do
  install_if_missing "${i}"
done
