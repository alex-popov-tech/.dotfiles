#!/usr/bin/env bash

set -e

data="$(/usr/local/bin/lpass export)"
export LC_ALL=en_US.UTF-8 && echo "$data" | gzip | /usr/local/bin/gpg --encrypt -r alex.popov.tech@gmail.com > /Volumes/BACKUP/lpass_$(date '+%F').gzip.gpg

# to decrypt
# gpg --decrypt ./lpass_2020-02-03.gzip.gpg | funzip
