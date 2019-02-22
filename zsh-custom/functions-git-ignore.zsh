#!/usr/bin/env zsh
function git-ignore() {
  commonly_ignored="vim,osx,linux,emacs,nanoc,eclipse,windows,intellij,jetbrains,sublimetext,intellij+iml,intellij+all,jetbrains+iml,jetbrains+all,microsoftoffice"
  all_ignored="${commonly_ignored},${@}"
  curl -L -s "https://www.gitignore.io/api/${all_ignored}"
}

function git-ignore-java() {
  git-ignore "java,java-web,code-java"
}

function git-ignore-rust() {
  git-ignore "c,c++,cmake"
}

function git-ignore-cpp() {
  git-ignore "c,c++,cmake,qt"
}

function git-ignore-golang() {
  git-ignore "go"
}

function git-ignore-haskell() {
  git-ignore "haskell"
}

function git-ignore-javascript() {
  git-ignore "node,webstorm+iml,webstorm+all"
}

function git-ignore-node() {
  git-ignore-javascript
}

function git-ignore-js() {
  git-ignore-javascript
}

function git-ignore-python() {
  git-ignore "virtualenv"
}
