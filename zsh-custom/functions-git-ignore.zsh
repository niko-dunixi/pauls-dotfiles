#!/usr/bin/env zsh
function git-ignore()
{
  curl -L -s "https://www.gitignore.io/api/${@}" -o .gitignore
}

function git-ignore-java
{
  git-ignore "osx,vim,java,nanoc,linux,emacs,maven,gradle,windows,eclipse,netbeans,jetbrains+all,intellij+iml"
}
