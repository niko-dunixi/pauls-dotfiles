#!/usr/bin/env zsh

function mvn-docker() {
  # Functions can only take arguments, which we want to get from the user so
  # we can pass them directly to docker. This is why we set the version of maven
  # via environment variable. If it's not set (EG: we're invoking it manually) the
  # function exits with a non-zero exit code.
  if [ -z "${MAVEN_DOCKER_TAG}" ] ; then
    echo "Set the MAVEN_DOCKER_TAG env variable before continuing"
    exit 1
  fi
  # We get the current path and we use some bash substituion to just get the current
  # directory's name.
  current_path="$(pwd)"
  current_directory="${current_path##*/}"
  current_maven="maven:${MAVEN_DOCKER_TAG}"
  echo "${current_maven}"
  # We now invoke docker.
  #  '--it' tells docker this command is interactive.
  #  '--rm' after this image has run to completion, docker will remove it (important since we're using the --name parameter)
  #  '--name' gives the current execution a name. This is used to enforce a singleton
  #      instance of maven in this current directory since Docker can run as many instances
  #      as we tell it to.
  #  '-v' This is the 'volume' we want to mount. We want to mount two of them in this case
  #      The first one is our local .m2 directory. We don't want it to download all the artifacts
  #      and their dependendies over and over again. It's a slow process, which kills productivity
  #      The second one is the current directory. This lets the docker image believe it's
  #      in the same directory we currently are in, which is the project folder
  #   '-w' The current working directory within the docker container. This was what we mounted
  #      the project folder to in the prior argument. It's arbitrary.
  docker run -it --rm --name "maven-${current_directory}" \
    -v "${HOME}/.m2:/root/.m2" \
    -v "$(pwd):/usr/src/mymaven" \
    -w /usr/src/mymaven "${current_maven}" mvn "${@}"
}

function mvn-jdk-8() {
  MAVEN_DOCKER_TAG="3.6-jdk-8" mvn-docker "${@}"
}

function mvn-jdk-11() {
  MAVEN_DOCKER_TAG="3.6-jdk-11" mvn-docker "${@}"
}

function mvn() {
  mvn-jdk-11 "${@}"  
}

function mvn-purge-deps()
{
  mvn dependency:purge-local-repository
}

function mvn-get-deps()
{
  mvn dependency:resolve
  mvn dependency:resolve-plugins
}

function mvn-purge()
{
  mvn dependency:purge-local-repository
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
  #find "${HOME}/.m2/repository/" -type f -iname "*.repositories" -exec rm -v \{\} \;
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

function mvn-create-javafx()
{
  mvn archetype:generate -DarchetypeGroupId=com.zenjava -DarchetypeArtifactId=javafx-basic-archetype
}
