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
  PYTHONWARNINGS="ignore" aws-adfs login --profile=master --adfs-host=adfs.wgu.edu --no-ssl-verification
}

function validate-template()
{
  aws-paul cloudformation validate-template --template-body "file://${@}"
}
