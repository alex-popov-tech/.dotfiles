#!/bin/zsh

set -e

filename=lpass_"$(date '+%F')".gzip.gpg

if ! $(/usr/local/bin/keybase fs stat /keybase/public/alex_popov_tech/$filename &>/dev/null)
then
  data="$(/usr/local/bin/lpass export --sync=now)"

  export LC_ALL=en_US.UTF-8 && echo "$data" | gzip | /usr/local/bin/gpg --encrypt -r alex.popov.tech@gmail.com > "/tmp/$filename"
  # to download and decrypt
  # scp router:/media/Main/lpass_2020-02-11.gzip.gpg ./lpass.gzip.gpg
  # gpg --decrypt ./lpass_2020-02-03.gzip.gpg | funzip
  scp "/tmp/$filename" "router:/media/Main/$filename"
  # to download and decrypt
  # keybase fs read /keybase/public/alex_popov_tech/lpass_2020-03-04.gzip.gpg | gpg --decrypt | funzip
  /usr/local/bin/keybase fs write "/keybase/public/alex_popov_tech/$filename" < "/tmp/$filename"
  rm "/tmp/$filename"
fi
