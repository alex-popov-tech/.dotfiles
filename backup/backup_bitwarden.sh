#!/usr/bin/env bash

# set -e
# set -v

# sessionkey=$(security find-generic-password -w -s alfred-bitwarden-session-key)
# rawresult=$(/usr/local/bin/bw list items --session "$sessionkey")
# prettyresult=$(echo "$rawresult" | jq)
# echo "$rawresult" | jq | gzip | gpg --encrypt -r alex.popov.tech@gmail.com > /Volumes/BACKUP/$(date '+%F').gzip.gpg

$HOME/.asdf/shims/node $HOME/.dotfiles/backup/backup_bitwarden.js
