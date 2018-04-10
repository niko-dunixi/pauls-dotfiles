#!/usr/bin/env zsh
function docker-clean()
{
  for cnt in $(docker ps -a -q); do
    docker rm -f "${cnt}"
  done
  for img in $(docker images -q); do
    docker rmi -f "${img}"
  done
  docker system prune -f
}
