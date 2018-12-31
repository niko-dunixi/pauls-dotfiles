#!/usr/bin/env zsh

# TODO: extrapolate this and place it as some kind of "import"?
function iscommand
{
  hash "${1}" 2>/dev/null
}

for py_version in $(ls "${HOME}/Library/Python/"); do
  echo "${py_version}"
  export PATH="${PATH}:${HOME}/Library/Python/${py_version}/bin"
done

# I don't like using anaconda (anymore), but if I am using it
# I should use it and source the profiles correctly
if iscommand conda; then
  # This is the old way
  # export PATH=/usr/local/anaconda3/bin:"${PATH}"

  # This is the new way
  . "/usr/local/anaconda3/etc/profile.d/conda.sh"
  conda activate
fi
