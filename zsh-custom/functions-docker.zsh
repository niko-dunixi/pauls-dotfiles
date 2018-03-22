#!/usr/bin/env zsh
function docker-clean()
{
  docker system prune -f
}
