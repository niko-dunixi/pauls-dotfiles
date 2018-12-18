#!/usr/bin/env bash
set -e
export PATH="${HOME}/.jenv/bin:${PATH}"
eval "$(jenv init -)"
# Shim the bin through 
if [ -f "${HOME}/.zshrc" ] && ! grep -q jenv "${HOME}/.zshrc"; then
  echo "Shimming ~/.zshrc"
  echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(jenv init -)"' >> ~/.zshrc
fi
if [ -f "${HOME}/.bash_profile" ] && ! grep -q jenv "${HOME}/.bash_profile"; then
  echo "Shimming ~/.bash_profile"
  echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(jenv init -)"' >> ~/.bash_profile
fi
mkdir -p "${HOME}/.jenv/versions/"

old_versions="$(jenv versions --bare)"
for java_version in ${old_versions}; do
  jenv remove "${java_version}"
done
# Manage all currently installed versions
my_os="$(uname)"
if [ "${my_os}" == "Darwin" ]; then
  cd /Library/Java/JavaVirtualMachines/
else
  cd /usr/lib/jvm
fi
for path in *; do
  # full_path="${jvm_master_directory}/${path}"
  # echo "${full_path}"
  jvm_directory="$(pwd)/${path}/Contents/Home/"
  if [ ! -d "${jvm_directory}" ]; then
    jvm_directory="$(pwd)/${path}"
  fi
  jenv add "${jvm_directory}"
done
# Set default to Java 8
jenv global 1.8
jenv rehash
# Get maven and gradle to play nice (you might have to run these two commands manually, but "jenv init" should make it work)
eval "$(jenv init -)"
jenv enable-plugin maven
jenv enable-plugin gradle
echo ""
