#!/usr/bin/env bash

tmp="/tmp/$(date '+%F')_cronerr"

chmod +x $1

$1 >/dev/null 2>$tmp ; if [ -s $tmp ] ; then mail -s BACKUP_ERROR alex.popov.tech@gmail.com < $tmp && rm $tmp ; fi
