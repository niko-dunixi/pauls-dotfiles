#!/usr/bin/env bash
set -e

# Uninstall Java 9 off the bat, so we can fix our local installation
if brew cask ls --versions "java" &>/dev/null; then
  echo "Uninstalling Java"
  brew cask uninstall java
fi

brew install jenv
brew cask install caskroom/versions/java8
brew cask install java

# Remove orphans or bad previous installs so we manage things from a clean state
old_versions="$(jenv versions --bare)"
echo "${old_versions}"
for java_version in ${old_versions}; do
  if [ "${java_version}" == "system" ]; then
    continue
  fi
  echo "Un-managing: ${java_version}"
  jenv remove "${java_version}"
done

for path in /Library/Java/JavaVirtualMachines/*; do
  full_path="${path}/Contents/Home"
  echo "Now managing: ${full_path}"
  jenv add "${full_path}"
done

jenv global 1.8
jenv rehash

# For whatever reason, maven doesn't seem to want to respect jenv.
# Let's work around that.
echo "JAVA_HOME=\$(/usr/libexec/java_home -v \$(jenv version-name))" > ~/.mavenrc
