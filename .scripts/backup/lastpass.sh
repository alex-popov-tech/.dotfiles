#!/bin/zsh

filename="lastpass_backup.gzip.gpg"
filepath="/tmp/$filename"
errpath="/tmp/pusherr"
echo '' > $errpath
export LC_ALL=en_US.UTF-8 && /usr/local/bin/lpass export --sync=now | gzip | /usr/local/bin/gpg --encrypt --trust-model always -r alex.popov.tech@gmail.com > "$filepath"
# gpg --decrypt ./lastpass_backup.gzip.gpg | funzip > lastpass.csv

mkdir -p $HOME/.backup
cd $HOME/.backup

cp -f "$filepath" "./$filename"
rm "$filepath"

git add "./$filename"
git commit -m "lpass backup from $(date)" 1>/dev/null
git push github master 2>&1 | tr -d '\n' | grep "error" 1>&2
git push gitlab master 2>&1 | tr -d '\n' | grep "error" 1>&2

