#! /usr/bin/env sh

set -e
set -v

cd $($HOME/.asdf/shims/node $HOME/.dotfiles/backup/backup_keybase.js)
name=keybase_$(date '+%F')
tar -czf $name.tar ./keybase
rm -rf ./keybase
cat ./$name.tar | gzip | /usr/local/bin/gpg --encrypt -r alex.popov.tech@gmail.com > /Volumes/BACKUP/$name.gzip.gpg
rm ./$name.tar
