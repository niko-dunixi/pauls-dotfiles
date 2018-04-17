#!/usr/bin/env zsh
function git-current-branch()
{
  git branch | grep '*' | awk '{print $2}'
}

function git-set-personal-author()
{
  git config user.name "Paul N. Baker"
  git config user.email "paul.nelson.baker@gmail.com"
}

function git-set-professional-author()
{
  git config user.name "Paul Baker"
  git config user.email "paul.baker@wgu.edu"
}
