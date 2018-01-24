#!/usr/bin/env bash
set -e
# Install OSX xcode utils
echo "Will install xcode-select cli utilities..."
sudo xcode-select --install || echo "... moving on"
# Install homebrew, then we'll install packages
if hash brew 2>/dev/null; then
  echo "Homebrew already installed, moving on to packages."
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Homebrew installed, moving on to packages."
fi
brew update && brew upgrade
echo "Installing from Brewfile:"
brew bundle
