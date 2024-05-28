#!/bin/bash

brew install docker
brew install colima
brew install docker-compose

# This isn't the best b/c it keeps adding it...
echo `jq '.cliPluginsExtraDirs =  [  "/opt/homebrew/lib/docker/cli-plugins" ]' ~/.docker/config.json` > ~/.docker/config.json


# Upsize the Colima VM memory from 2G to 8G (2G fails every time for JVMs)
if grep -q "memory: 2" "$HOME/.colima/_templates/default.yaml"
then
    echo "*** The 2G default Docker/Colima VM memory was not found in $HOME/.colima/_templates/default.yaml - skipping, but check to make sure it is the correct size"
else
    echo "Increasing the default memory for the Docker/Colima VM from 2G to 8G in $HOME/.colima/_templates/default.yaml"
    sed -i '' 's/memory: 2/memory: 8/' "$HOME/.colima/default/colima.yaml"
fi

# This auto starts Colima as a  background task
brew services start colima