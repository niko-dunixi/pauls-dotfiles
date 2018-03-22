#!/usr/bin/env zsh
function git-ignore()
{
  curl -L -s "https://www.gitignore.io/api/${@}"
}

function git-ignore-java()
{
  git-ignore "osx,vim,java,nanoc,linux,emacs,maven,gradle,windows,eclipse,netbeans,jetbrains+all,intellij+iml"
}

function git-ignore-cpp()
{
  git-ignore "c,vim,osx,c++,linux,cmake,windows,jetbrains+all,intellij,intellij+all,intellij+iml,qt"
}

function git-ignore-golang()
{
  git-ignore "go,vim,osx,linux,windows,intellij,intellij+all,intellij+iml"
}

function git-ignore-haskell()
{
  git-ignore "vim,osx,linux,windows,haskell,intellij,sublimetext,intellij+all,intellij+iml"
}

function git-ignore-javascript()
{
  git-ignore "osx,vim,node,linux,windows,webstorm,intellij,intellij+all,webstorm+iml,webstorm+all,intellij+iml"
}

function git-ignore-node()
{
  git-ignore-javascript
}

function git-ignore-js()
{
  git-ignore-javascript
}

function git-ignore-python()
{
  git-ignore "osx,vim,linux,python,windows,intellij,virtualenv,intellij+all,intellij+iml"
}
