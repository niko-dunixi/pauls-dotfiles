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

# This is the most surefire way to point to the file without doubling
# down on the setup-scripts part within the path
current_directory=$(pwd)
root_directory="${current_directory%setup-scripts}"
brewfile_path="${root_directory}/setup-scripts/Brewfile"

rm -rfv "${HOME}/Library/Caches/Homebrew/*"
brew cleanup -s
brew update && brew upgrade
# Install XCode and make sure its license has been accepted
brew install mas
mas install 497799835
sudo xcodebuild -license accept
echo "Installing from Brewfile: ${brewfile_path}"
brew bundle --file="${brewfile_path}"
