#!/bin/bash
# Author: Imam Omar Mochtar (iomarmochtar@gmail.com)
# Version: 0.1
# 
# Changelog
# 0.1
# === 
# - Initial


WORKDIR=`cd "$(dirname "$0")" ; pwd -P` 
source $WORKDIR/envs

# if format not specified then add it
echo $BACKUP_PATH | grep -e "\.$FORMAT\$" > /dev/null || BACKUP_PATH="${BACKUP_PATH}*.${FORMAT}"

# if not a single/direct backup file
ls $BACKUP_PATH 2> /dev/null > /dev/null 
if [[ $? != 0 ]]; then
    echo "backup not found with pattern $BACKUP_PATH !!"
    exit 1
fi

# iterrate all backup file to restore
for backupFile in `ls $BACKUP_PATH`; do
    account=`basename $backupFile | sed -e 's/\.'$FORMAT'$//'`
    echo "Restoring file $backupFile for account $account"
    $ZMBOX -z -m $account -t $TIMEOUT postRestURL "//?fmt=${FORMAT}${RESTORE_ARGS}" $backupFile
done


echo '= DONE ='	
