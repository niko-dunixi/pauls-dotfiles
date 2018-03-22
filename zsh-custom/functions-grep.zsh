#!/usr/bin/env zsh
function grep-java()
{
  ack -i --java "${@}"
}

function grep-go()
{
  ack -i --go "${@}"
}

function grep-cpp()
{
  ack -i --cpp "${@}"
}
