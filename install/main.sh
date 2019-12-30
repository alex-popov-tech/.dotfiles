#!/usr/bin/env bash

function main() {
  [ ! -d $HOME/.dotfiles ] && git clone https://github.com/aleksanderpopov/.dotfiles.git $HOME/.dotfiles
  cd $HOME/.dotfiles
  git pull

  sudo -v

  scripts="
    ./scripts/langs.sh
    ./scripts/software.sh
    ./scripts/zshell.sh
    ./scripts/nvim.sh
    ./scripts/tmux.sh
    ./scripts/link_configs.sh
    ./scripts/macos.sh
  "

  for script in $scripts; do
    chmod +x $script && DPATH=$(pwd) $script
  done

}
main
