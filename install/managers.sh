#!/usr/bin/env bash

function main() {
  DPATH=$HOME/.dotfiles
  [ ! -d $DPATH ] && git clone https://github.com/aleksanderpopov/.dotfiles.git $DPATH
  cd $DPATH
  git pull

  chmod +x ./scripts/managers.sh && DPATH=$DPATH ./scripts/managers.sh
}
main
