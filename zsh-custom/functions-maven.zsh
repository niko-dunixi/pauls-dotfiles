#!/usr/bin/env zsh

function mvn-purge-deps()
{
  mvn dependency:purge-local-repository
}

function mvn-get-deps()
{
  mvn dependency:resolve
  mvn dependency:resolve-plugins
}

function mvn-get-sources()
{
  mvn dependency:sources
  mvn dependency:resolve -Dclassifier=javadoc
}

function mvn-set-version()
{
  mvn versions:set -DnewVersion="${1}"
  mvn versions:update-child-modules
}

function mvn-install-as()
{
  if [ "${#}" -ne 1 ]; then
    echo "One and only one argument expected, which will be the artifact version."
    return 1
  fi
  original_version="$(mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version|grep -Ev '(^\[|Download\w+:)')"
  mvn-set-version "${1}"
  mvn install -Dmaven.test.skip=true -Dgithub.site.skip=true -Dgpg.skip=true
  install_failed="${?}"
  # Rest back to original name for the sake of version control."
  mvn-set-version "${original_version}"
  #  If the install failed, let me know!
  if [[ "${install_failed}" -ne "0" ]]; then
    echo "=========================="
    echo "= THIS FAILED TO INSTALL ="
    echo "=========================="
  else
    echo "=========================="
    echo "= INSTALL WORKED LOCALLY ="
    echo "=========================="
  fi
  return "${install_failed}"
}

function mvn-wrapify()
{
  mvn -N io.takari:maven:wrapper
}
