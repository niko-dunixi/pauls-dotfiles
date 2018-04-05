#!/usr/bin/env zsh
function git-current-branch()
{
  git branch | grep '*' | awk '{print $2}'
}
