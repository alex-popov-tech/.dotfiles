#!/usr/bin/env bash

set -e

lpass="/usr/local/bin/lpass"
keybase="/usr/local/bin/keybase"
gpg="/usr/local/bin/gpg"
filename=lpass_"$(date '+%F')".gzip.gpg

if ! $($keybase fs stat /keybase/public/alex_popov_tech/$filename &>/dev/null)
then
  data="$($lpass export --sync=now)"

  export LC_ALL=en_US.UTF-8 && echo "$data" | gzip | $gpg --encrypt -r alex.popov.tech@gmail.com > "/tmp/$filename"
  # to download
  # scp admin@192.168.31.1:/media/Main/lpass_2020-02-11.gzip.gpg ./lpass.gzip.gpg
  scp "/tmp/$filename" "admin@192.168.31.1:/media/Main/$filename"
  # to download
  # keybase fs read /keybase/public/alex_popov_tech/lpass_2020-02-11.gzip.gpg > ./lpass.gzip.gpg
  $keybase fs write "/keybase/public/alex_popov_tech/$filename" < "/tmp/$filename"
  rm "/tmp/$filename"
  # to decrypt
  # gpg --decrypt ./lpass_2020-02-03.gzip.gpg | funzip
fi
