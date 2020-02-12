#! /usr/bin/env sh

set -e

filename=keybase_$(date '+%F').tar.gzip.gpg

if [ "ssh admin@192.168.31.1 stat /media/Main/$filename \> /dev/null 2\>\&1" ]; then
  path=$($HOME/.asdf/shims/node $HOME/.dotfiles/backup/keybase.js)
  cd $path

  export LC_ALL=en_US.UTF-8 && tar -cf - ./keybase | gzip | /usr/local/bin/gpg --encrypt -r alex.popov.tech@gmail.com > "./$filename"
  rm -rf ./keybase
  scp "./$filename" "admin@192.168.31.1:/media/Main/"
  cat "./$filename" | /usr/local/bin/keybase fs write "/keybase/public/alex_popov_tech/$filename"
  rm "./$filename"
  # to download and decrypt
  # scp admin@192.168.31.1:/media/Main/keybase_2020-02-11.tar.gzip.gpg ./keybase.tar.gzip.gpg && gpg --decrypt -o keybase.tar.gzip ./keybase.tar.gzip.gpg
fi


