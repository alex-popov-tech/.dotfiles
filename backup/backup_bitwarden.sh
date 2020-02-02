#! /usr/bin/env sh
set -e

sessionkey=$(security find-generic-password -w -s alfred-bitwarden-session-key)
rawresult=$(bw list items --session "$sessionkey")
prettyresult=$(echo "$rawresult" | jq)
echo "$rawresult" | jq | gzip | gpg --encrypt -r alex.popov.tech@gmail.com > /Volumes/BACKUP/$(date '+%F').gzip.gpg

