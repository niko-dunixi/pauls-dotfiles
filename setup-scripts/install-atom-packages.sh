#!/usr/bin/env bash
set -e
alias api='apm install'
echo "Attempting to install atom packages..."
api language-haskell
api haskell-ghc-mod
api ide-haskell

echo "Complete!"
