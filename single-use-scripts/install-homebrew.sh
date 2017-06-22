#!/usr/bin/env bash
set -e
# Install homebrew, then well install packages
if hash brew 2>/dev/null; then
  echo "Homebrew already installed, moving on to packages."
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Homebrew installed, moving on to packages."
fi
brew update && brew upgrade
PACKAGES=( 'bash-completion' 'brew-cask-completion' 'm-cli' 'wget' 'coreutils' \
            'chromedriver' 'boost' 'boost-python' 'exercism' 'gradle' 'imagemagick' \
            'graphviz' 'git' 'hg' 'git-secrets' 'maven' 'clang-format' 'node' 'tree' 'cmake' \
            'kotlin' 'qemu' 'libvirt' 'mas' 'unrar' 'python' 'python3' )
CASK_PACKAGES=( 'atom' 'docker' 'kitematic' 'vagrant' 'virtualbox' 'firefox' \
                'xquartz' 'java' 'android-sdk' 'android-ndk' 'haskell-platform' )
function enterkey
{
  echo ""
  echo "Holding script execution, please follow caveat"
  echo "instructions (if any) and then resume."
  read -r -p "Press enter key to continue..."
}

brew tap caskroom/cask
brew tap homebrew/science
for i in "${CASK_PACKAGES[@]}"; do
  if brew cask ls --versions "${i}" > /dev/null; then
    echo "${i} is already installed"
  else
    brew cask install "${i}"
    enterkey
  fi
done
for i in "${PACKAGES[@]}"; do
  if brew ls --versions "${i}" > /dev/null; then
    echo "${i} is already installed"
  else
    brew install "${i}"
    enterkey
  fi
done

echo ""
echo "This has completed installing homebrew and packages!"
