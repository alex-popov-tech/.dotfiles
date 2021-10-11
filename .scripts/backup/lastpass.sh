#!/bin/zsh

set -e

filename="lastpass_backup.gzip.gpg"
filepath="/tmp/$filename"
export LC_ALL=en_US.UTF-8 && /usr/local/bin/lpass export --sync=now | gzip | /usr/local/bin/gpg --encrypt -r alex.popov.tech@gmail.com > "$filepath"
currentsize=$(wc -c "$filepath" | awk '{print $1}')
existingsize=$(wc -c "$HOME/.backup/$filename" | awk '{print $1}')

if [ $currentsize != $existingsize ]; then
    # scp "router:/media/Main/$filename" ./lpass.gzip.gpg
    # gpg --decrypt ./lastpass_backup.gzip.gpg | funzip
    scp "$filepath" "router:/media/Main/$filename"

    # keybase fs read /keybase/public/alex_popov_tech/lastpass_backup.gzip.gpg | gpg --decrypt | funzip
    /usr/local/bin/keybase fs rm "/keybase/public/alex_popov_tech/$filename"
    /usr/local/bin/keybase fs write "/keybase/public/alex_popov_tech/$filename" < "/tmp/$filename"

    mkdir -p $HOME/.backup
    cd $HOME/.backup
    cp -f "$filepath" "./$filename"
    git add "./$filename"
    git commit -m "lpass backup from $(date)"
    git push github master > /dev/null

    rm "$filepath"
fi
