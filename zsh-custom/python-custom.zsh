#!/usr/bin/env zsh

# TODO: extrapolate this and place it as some kind of "import"?
function iscommand
{
  hash "${1}" 2>/dev/null
}

# I don't like using anaconda (anymore), but if I am using it
# I should use it and source the profiles correctly
if iscommand conda; then
  # This is the old way
  # export PATH=/usr/local/anaconda3/bin:"${PATH}"

  # This is the new way
  . "/usr/local/anaconda3/etc/profile.d/conda.sh"
  conda activate
fi
