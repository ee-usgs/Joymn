#!/bin/bash

# intall java based on a specific sdkman version name

JAVA_VERSION_NAME="$1"

echo "This will install the latest Temurin patch of the requested version of java."
echo "This takes one argument of the form: MAJOR.MINOR"
echo "E.g.: ./install_java.sh 21.0  will install the most recent version of Temurin java 21.0.X"

echo "sdk_dir: ${SDKMAN_DIR}"

source "$HOME/.sdkman/bin/sdkman-init.sh"


LATEST_JDK=`sdk ls java | grep -E -m 1 -o '11\.0\.\d+(\.\d+)?-tem'`

echo "For the requested version '${JAVA_VERSION_NAME}', the version '${LATEST_JDK}' will be installed"



# if [[ -n "$ZSH_VERSION" ]]; then
#   source ~/.zshrc
# elif [[ -n "$BASH_VERSION" ]]; then
#   source ~/.bash_profile
# fi