#!/usr/bin/env zsh
#alias aws-paul="aws --profile paulbaker"
#alias aws-dev="aws --profile wgu-dev"
#alias aws-sbx="aws --profile sbx"
function aws-sbx()
{
  aws --profile sbx "${@}"
}

function aws-paul()
{
  aws --profile paulbaker "${@}"
}

function aws-token-refresh()
{
  aws-adfs login --profile=master --adfs-host=adfs.wgu.edu
}
