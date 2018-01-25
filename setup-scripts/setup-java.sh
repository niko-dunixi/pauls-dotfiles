#!/usr/bin/env bash
set -e

old_versions="$(jenv versions --bare)"
for java_version in ${old_versions}; do
  jenv remove "${java_version}"
done
# Manage all currently installed versions
for path in /Library/Java/JavaVirtualMachines/*; do
  full_path="${path}/Contents/Home"
  jenv add "${full_path}"
done
# Set default to Java 8
jenv global 1.8
jenv rehash
# Get maven and gradle to play nice (you might have to run these two commands manually, but "jenv init" should make it work)
eval "$(jenv init -)"
jenv enable-plugin maven
jenv enable-plugin gradle
echo ""
jenv init || exit 0
