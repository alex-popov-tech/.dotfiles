#! /usr/bin/env sh

set -e

filename=keybase_$(date '+%F').tar.gzip.gpg
keybase="/usr/local/bin/keybase"
gpg="/usr/local/bin/gpg"

if ! $($keybase fs stat /keybase/public/alex_popov_tech/$filename &>/dev/null)
then
  $HOME/.asdf/shims/node $HOME/.dotfiles/backup/keybase.js
  cd /tmp

  export LC_ALL=en_US.UTF-8 && tar -cf - ./keybase | gzip | $gpg --encrypt -r alex.popov.tech@gmail.com > "./$filename"
  rm -rf ./keybase
  scp "./$filename" "router:/media/Main/"
  $keybase fs write "/keybase/public/alex_popov_tech/$filename" < "./$filename"
  rm "./$filename"
  # to download and decrypt
  # scp admin@192.168.31.1:/media/Main/keybase_2020-02-11.tar.gzip.gpg ./keybase.tar.gzip.gpg && gpg --decrypt -o keybase.tar.gzip ./keybase.tar.gzip.gpg
fi

