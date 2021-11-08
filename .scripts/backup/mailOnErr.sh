#!/bin/zsh

tmp="/tmp/$(date '+%F')_cronerr"

chmod +x $1

while  true ; do
  $1 >/dev/null 2>$tmp;
  if [ -s $tmp ]
  then
    mail -s BACKUP_INFO alex.popov.tech@gmail.com < $tmp
    rm $tmp
    sleep 3600
  else
    break
  fi
done
