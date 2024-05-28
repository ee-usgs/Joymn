#!/bin/bash

# Install Homebrew and make sure it is on the path

# Permissions needed for homebrew
sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions

# Install Homebrew - A Mac package manager - https://brew.sh/
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# Add homebrew to bash path, if not already there
if grep -q "PATH=/opt/homebrew/bin" ~/.bash_profile
then
    echo ".bash_profile already contains a PATH entry for '/opt/homebrew/bin' - Skipping adding homebrew to bash path"
else
    echo 'export PATH=/opt/homebrew/bin:$PATH' >> ~/.bash_profile
fi


# Add homebrew to zsh path, if not already there
if grep -q "path+=('/usr/local/bin/brew')" ~/.bash_profile
then
    echo ".zprofile already contains a PATH entry for '/opt/homebrew/bin' - Skipping adding homebrew to zsh path"
else
    echo "path+=('/usr/local/bin/brew')" >> ~/.zprofile
fi