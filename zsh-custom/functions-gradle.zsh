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
  mkdir -p ./src/{main,test}/java
}

function gradle-init-kotlin-native()
{
  [ ! -z "${1}" ] || fail
  mkdir -p "${1}/src/main/kotlin"
  (
    echo "buildscript {"
    echo "  repositories {"
    echo "    mavenCentral()"
    echo "    maven {"
    echo "      url \"https://dl.bintray.com/jetbrains/kotlin-native-dependencies\""
    echo "    }"
    echo "  }"
    echo "  dependencies {"
    echo "    classpath \"org.jetbrains.kotlin:kotlin-native-gradle-plugin:+\""
    echo "  }"
    echo "}"
    echo ""
    echo "apply plugin: 'konan'"
    echo ""
    echo "konan.targets = ['macbook', 'linux', 'mingw']"
    echo ""
    echo "konanArtifacts {"
    echo "  program('hello')"
    echo "}"
  ) > "${1}/build.gradle"
  (
    echo "fun main(args: Array<String>) {"
    echo "  println(\"Hello Gradle!\")"
    echo "}"
  ) > "${1}/src/main/kotlin/hello.kt"
}
