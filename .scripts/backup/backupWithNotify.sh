#!/bin/zsh

terminal-notifier -sound default \
  -title "Start backing up your passwords?" \
  -message "Make sure LastPass is authorized and click on this notification" \
  -execute "zsh $HOME/.dotfiles/.scripts/backup/backup.sh"
