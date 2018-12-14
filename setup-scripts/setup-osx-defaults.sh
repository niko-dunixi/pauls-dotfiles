#!/usr/bin/env bash
set -e

# Disable iTunes auto-start
# https://apple.stackexchange.com/a/344186/124061
defaults write com.apple.iTunesHelper ignore-devices 1

