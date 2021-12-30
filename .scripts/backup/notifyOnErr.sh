#!/bin/zsh

chmod +x $1

err=$($1 2>&1)
if [[ $err = *[!\ ]* ]]; then
  echo $err > /tmp/backup_err | terminal-notifier -sound Glass -title "Backup finished with errors:" -execute "open -a TextEdit /tmp/backup_err"
fi
