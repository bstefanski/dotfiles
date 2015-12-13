#!/bin/sh
REPOSITORY=/mnt/data/backup/noname_pc.attic  #no backslash at the end of this

LOGFILE=/var/log/atticbackup

###############start of script#################
exec >> $LOGFILE 2>&1

#simple function that just prints the time and the info you pass to it
echotime () {
  echo "---------- `date +%Y-%m-%d--%H:%M:%S` ----$1------------"
}

echotime "Script Start"

# Backup all of / except a few excluded directories
# if your running into issues, add -v after create for verbose mode
# the below / means backup all of root.
echotime "ATTIC CREATE"
attic create --stats --do-not-cross-mountpoints --exclude-caches    \
    $REPOSITORY::host.stscode-`date +%Y-%m-%d--%H:%M:%S`                      \
    /                                                                         \
    --exclude /sys                                                            \
    --exclude /mnt                                                            \
    --exclude /dev                                                            \
    --exclude /media                                                          \
    --exclude /lost+found                                                     \
    --exclude /proc                                                           \
    --exclude /run                                                            \
    --exclude /home/bartekmanj/.cache

# Use the `prune` subcommand to maintain 7 daily, 4 weekly
# and 6 monthly archives.
echotime "ATTIC PRUNE"
attic prune -v $REPOSITORY --keep-hourly=23 --keep-daily=7 --keep-weekly=4 --keep-monthly=6

# end of script
echotime "End of Script"
