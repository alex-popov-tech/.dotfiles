#! /usr/bin/env sh

set -e

name=keybase_$(date '+%F')

if [ "ssh admin@192.168.31.1 stat /media/BACKUP/$name.tar \> /dev/null 2\>\&1" ]; then
  path=$($HOME/.asdf/shims/node $HOME/.dotfiles/backup/backup_keybase.js)
  cd $path
  tar -czf $name.tar ./keybase
  rm -rf ./keybase
  export LC_ALL=en_US.UTF-8 && cat ./$name.tar | gzip | /usr/local/bin/gpg --encrypt -r alex.popov.tech@gmail.com > "./$name.tar.gzip.gpg"
  rm ./$name.tar
  # to download
  # scp admin@192.168.31.1:/media/BACKUP/keybase_2020-02-10.tar.gzip.gpg ./keybase.tar.gzip.gpg
  scp "./$name.tar.gzip.gpg" admin@192.168.31.1:/media/BACKUP/
  cat "./$name.tar.gzip.gpg" | /usr/local/bin/keybase fs write "/keybase/public/alex_popov_tech/$name.gzip.gpg"
  rm "./$name.tar.gzip.gpg"
  # to decrypt
  # gpg -o ./keybase.tar.gzip -d ./keybase_2020-02-04.gzip.gpg
fi


