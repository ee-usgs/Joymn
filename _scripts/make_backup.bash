#!/bin/bash

echo "This command will copy all known useful paths to a directory to be transfered to a new machine."
echo "This assumes you keep all your important data in ~/datausgs - Adjust the script if that is not true."
read -r -p "Are you sure you want to run this? [y/N] " response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "Great!  Continuing on..."
else
  echo "OK, quitting"
  exit 0;
fi

echo "There are some caches that can be cleared before running - see source code"

### Some pre-run cache clearing (optional)
# `rm ~/.gradle/daemon/*/daemon-*.out.log`
# `rm -rf ~/.gradle/caches/*`
# Also be sure to empty browser caches to save fiel transfer time...

HOME_DIR_NAME="from_home"
TRANSFER_BACKUP_DIR="${HOME}/tmp/transfer_backup"
HOME_BACKUP_DIR="${TRANSFER_BACKUP_DIR}/${HOME_DIR_NAME}"
TAR_FILE_PATH="${HOME_BACKUP_DIR}.tar.gz"
HOME_BACKUP_DIR_SLASH="${HOME_BACKUP_DIR}/"

mkdir -p "${HOME_BACKUP_DIR_SLASH}"

# Home directories
rsync -a "$HOME/Applications" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/datausgs" "${HOME_BACKUP_DIR_SLASH}"

echo "Home directories done"

# Home dot files
rsync -a "$HOME/.bash_profile" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.bashrc" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.gitconfig" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.gitignore_global" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.profile" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.testcontainers.properties" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.zshrc" "${HOME_BACKUP_DIR_SLASH}"

echo "Home dot files done"


# Home dot directories
rsync -a "$HOME/.3T" "${HOME_BACKUP_DIR_SLASH}"  # MongoDB Client
rsync -a "$HOME/.bash_sessions" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.colima" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.docker" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.gradle" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.lima" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.m2" "${HOME_BACKUP_DIR_SLASH}"
rsync -a "$HOME/.ssh" "${HOME_BACKUP_DIR_SLASH}"

echo "Home dot directories done"

# User Library
rsync -a "$HOME/Library/Application Support" "${HOME_BACKUP_DIR}/Library/"
rsync -a "$HOME/Library/DBeaverData" "${HOME_BACKUP_DIR}/Library/"
rsync -a "$HOME/Library/Fonts" "${HOME_BACKUP_DIR}/Library/"
rsync -a "$HOME/Library/Safari/Bookmarks.plist" "${HOME_BACKUP_DIR}/Library/Safari/"


## These are more optional
rsync -a "$HOME/Documents" "${HOME_BACKUP_DIR_SLASH}"

echo "Home documents done"

echo "##########################################################"
echo "# Finished copying files - now taring up for quicker moving."
echo "##########################################################"

sudo tar -czpvf "${TAR_FILE_PATH}" -C "${TRANSFER_BACKUP_DIR}" "${HOME_DIR_NAME}"

echo "##########################################################"
echo "# Done."
echo "# Files zipped to: ${HOME_BACKUP_DIR}.tar.bz2"
echo "##########################################################"
echo "# Be sure to double check that OneDrive files sync'ed b/c they are skipped here."