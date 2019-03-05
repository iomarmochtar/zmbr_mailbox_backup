Wrapping zmmailbox commands to backup user's data (Email, Calendar, etc)


## Usage

Adjust the configuration as you need.
```sh
vim envs
```

run backup script with destination folder path as first argument. Example:
```sh
bash mbxBackup.sh /mnt/backup_zimbra
```

for restoring mailbox run script with backup folder as first argument. Example:
```sh
bash mbxRestore.sh /mnt/backup_zimbra/02_04_2016
```


[@Omar Mochtar](mailto:iomarmochtar@gmail.com)
