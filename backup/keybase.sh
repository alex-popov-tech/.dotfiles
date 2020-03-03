#!/bin/zsh

set -e

filename=keybase_$(date '+%F').tar.gzip.gpg

if ! $(keybase fs stat /keybase/public/alex_popov_tech/$filename &>/dev/null)
then
  $HOME/.asdf/shims/node $HOME/.dotfiles/backup/keybase.js
  cd /tmp

  export LC_ALL=en_US.UTF-8 && tar -cf - ./keybase | gzip | gpg --encrypt -r alex.popov.tech@gmail.com > "./$filename"
  rm -rf ./keybase
  # to download and decrypt
  # scp admin@192.168.31.1:/media/Main/keybase_2020-02-11.tar.gzip.gpg ./keybase.tar.gzip.gpg && gpg --decrypt -o keybase.tar.gzip ./keybase.tar.gzip.gpg
  scp "./$filename" "router:/media/Main/"
  # keybase fs read /keybase/public/alex_popov_tech/keybase_2020-03-04.tar.gzip.gpg | gpg --decrypt | funzip > ./keybase.tar
  keybase fs write "/keybase/public/alex_popov_tech/$filename" < "./$filename"
  rm "./$filename"
fi

