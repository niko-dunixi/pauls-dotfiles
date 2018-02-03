#!/usr/bin/env bash
set -e
# Use functions instead of aliases within shellscripts
# https://stackoverflow.com/a/41764462/1478636
api() {
  apm install "${@}"
}

echo "Attempting to install atom packages..."
api language-haskell
api haskell-ghc-mod
api ide-haskell

echo "Complete!"
