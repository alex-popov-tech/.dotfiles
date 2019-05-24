#!/usr/bin/env bash

function main() {
  [ ! -d $HOME/.dotfiles ] && git clone https://github.com/aleksanderpopov/.dotfiles.git $HOME/.dotfiles
  cd $HOME/.dotfiles

  chmod +x ./scripts/macos_optional.sh && ./scripts/macos_optional.sh
}
main
