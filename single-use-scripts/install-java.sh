#!/usr/bin/env bash
set -e
# Uninstall Java 9 off the bat, so we can fix our local installation
if brew cask ls --versions "java" &>/dev/null; then
  echo "Uninstalling Java 9"
  brew cask uninstall java
fi
if brew cask ls --versions "java8" &>/dev/null; then
  echo "Uninstalling Java 8"
  brew cask uninstall java8
fi
if brew ls --version "jenv" &>/dev/null; then
  echo "Uninstalling jenv"
  brew uninstall jenv
fi
(
  if [ -d "/Library/Java/JavaVirtualMachines/" ]; then
    cd "/Library/Java/JavaVirtualMachines/"
    sudo rm -rf ./*
  fi
)
# Install jenv, java8 and java9
brew install jenv
mkdir -p "${HOME}/.jenv/versions/"
brew cask install caskroom/versions/java8
brew cask install java
# Remove orphans or bad previous installs so we manage things from a clean state
old_versions="$(jenv versions --bare)"
for java_version in ${old_versions}; do
  jenv remove "${java_version}"
done
# Manage all currently installed versions
for path in /Library/Java/JavaVirtualMachines/*; do
  full_path="${path}/Contents/Home"
  jenv add "${full_path}"
done
eval "$(jenv init -)"
# Set default to Java 8
jenv global 1.8
jenv rehash
# Get maven and gradle to play nice (you might have to run these two commands manually)
jenv enable-plugin maven
jenv enable-plugin gradle
echo ""
jenv init
