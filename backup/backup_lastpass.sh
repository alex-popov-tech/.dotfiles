#!/usr/bin/env bash

set -e

data="$(/usr/local/bin/lpass export)"
filename=lpass_"$(date '+%F')".gzip.gpg

if [ "ssh admin@192.168.31.1 stat /media/BACKUP/$filename \> /dev/null 2\>\&1" ]; then
  export LC_ALL=en_US.UTF-8 && echo "$data" | gzip | /usr/local/bin/gpg --encrypt -r alex.popov.tech@gmail.com > /tmp/"$filename"
  # to download
  # scp admin@192.168.31.1:/media/BACKUP/lpass_2020-02-10.tar.gzip.gpg ./lpass.gzip.gpg
  scp "/tmp/$filename" admin@192.168.31.1:/media/BACKUP/
  # to decrypt
  # gpg --decrypt ./lpass_2020-02-03.gzip.gpg | funzip
  cat "/tmp/$filename" | /usr/local/bin/keybase fs write "/keybase/public/alex_popov_tech/$filename"
  rm "/tmp/$filename"
fi

