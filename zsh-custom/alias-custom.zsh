#!/usr/bin/env zsh
alias ll="ls -alh"

function date-utc()
{
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}
