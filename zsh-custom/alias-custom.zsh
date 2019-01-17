#!/usr/bin/env zsh
alias ll="ls -alh"

function date-utc()
{
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

function shrug()
{
  echo '¯\_(ツ)_/¯'
}

function interobang()
{
  echo '‽'
}

function interobang-paul()
{
  echo "$(interobang)aul Baker!"
}

function cycle-magnet()
{
  if [ -d /Applications/Magnet.app ]; then
    pkill -f Magnet
    open -a Magnet
  fi
}

function check-port()
{
  for port in "${@}"; do
    lsof -nP -i4TCP:"${port}" | grep LISTEN
  done
}

function free-port()
{
  for port in "${@}"; do
    check-port "${port}" | awk '{ print $2 }' | xargs kill
  done
}

function free-port-8080()
{
  free-port 8080
}
#function airport()
#{
#  ap=$(find /System -type f -name "airport" -print 2>/dev/null | head -n 1)
#  $(sudo ap "${@}")
#}
#
#function find-my-friends()
#{
#  airport en1 sniff 1
#}
