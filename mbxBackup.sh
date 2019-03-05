#!/bin/bash
# Author: Imam Omar Mochtar (iomarmochtar@gmail.com)
# Version: 0.1
# 
# Changelog
# 0.1
# === 
# - Initial
#

asZimbra(){
    su - zimbra -c "$1"
}

WORKDIR=`cd "$(dirname "$0")" ; pwd -P` 
source $WORKDIR/envs

if [ ! -d $BACKUP_PATH ]; then
    echo "Backup path $BACKUP_PATH is not exists"
    exit 1
fi

if [ "$USERS"x == 'x' ]; then
    USERS=`$ZMPROV -l gaa`    
fi

mkdir -p $DEST

for user in $USERS; do
    backupUser="$DEST/${user}.${FORMAT}"
    if [ -f $backupUser ]; then
        rm -f $backupUser
    fi
    echo "Backup user data $user to path $backupUser"
    $ZMBOX -z -m $user -t $TIMEOUT getRestURL "//?fmt=${FORMAT}${BACKUP_ARGS}" > $backupUser 
done

if [ $LDAP_BACKUP == 'y' ]; then
    LDAP_DIR="$DEST/ldap_backup"
    echo "BACKUP LDAP DATA to $LDAP_DIR"
    if [ -d $LDAP_DIR ]; then
        rm -rf $LDAP_DIR
    fi
    mkdir -p $LDAP_DIR
    chown zimbra:zimbra $LDAP_DIR
    asZimbra "$ZMSLAP $LDAP_DIR" 
    asZimbra "$ZMSLAP -c $LDAP_DIR" 
    asZimbra "$ZMSLAP -a $LDAP_DIR" 
fi

echo '= DONE ='
