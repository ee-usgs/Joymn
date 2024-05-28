#!/bin/bash

echo "This command will restore files from the 'make_backup.bash' script."
echo "This may mess with apps and settings.  Please review what will be backed up in the 'make_backup.bash' script."
echo "You will have a chance to specify a target directory to restore to."
read -r -p "Are you sure you want to run this? [y/N] " response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "Great!  Continuing on..."
else
  echo "OK, quitting"
  exit 0;
fi


TRANSFER_BACKUP_DIR="${HOME}/tmp/transfer_backup"
HOME_BACKUP_DIR="${TRANSFER_BACKUP_DIR}/from_home"
TAR_FILE_PATH="${HOME_BACKUP_DIR}.tar.gz"
HOME_BACKUP_DIR_SLASH="${HOME_BACKUP_DIR}/"



HOME_SOURCE="$HOME/tmp/transfer_backup/from_home/"

# echo "Will untar ${TAR_FILE_PATH} to ${TRANSFER_BACKUP_DIR}"
# sudo tar -xzvpf "${TAR_FILE_PATH}" -C "${TRANSFER_BACKUP_DIR}"
# exit 0;


read -r -p "Restore files to what directory?  Use default to restore to home, something else for testing (no trailnig slash) [${HOME}]" TARGET_DIR

if [ -z "$TARGET_DIR" ]
then
      TARGET_DIR="${HOME}"
fi

if [[ "${TARGET_DIR: -1}" != "/" ]]
then
    echo "Using target directory: ${TARGET_DIR}"
else
  echo "The target directory must not include a trailng slash: ${TARGET_DIR}.  Stopping."
  exit 0;
fi


HOME_SOURCE="$HOME/tmp/transfer_backup/from_home/"

rsync -aP "${HOME_SOURCE}" "${TARGET_DIR}"


echo "##########################################################"
echo "# Done."
echo "##########################################################"
