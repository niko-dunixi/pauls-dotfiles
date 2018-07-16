#!/usr/bin/env bash


# function create-java-fx()
# {
#     capture_file="$(mktemp)"
#     script -q "${capture_file}" "mvn archetype:generate -DarchetypeGroupId=com.zenjava -DarchetypeArtifactId=javafx-basic-archetype"
#     cat "${capture_file}"
# }

function gradle-from-maven()
{
  gradle init --type pom
  if [ -f "pom.xml" ]; then
    mv "pom.xml" ".pom.xml.$(date +%s).backup"
  fi
}

function create-java-folder-struct()
{
  mkdir -p ./src/{main,test}/{java,resources}
}
