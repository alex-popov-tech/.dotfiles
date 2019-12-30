#!/usr/bin/env bash

function main() {

  echo "+---------------------------------+"
  echo "|        Installing Tmux          |"
  echo "+---------------------------------+"
  brew install tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  ln -fsv $DPATH/configs/tmux.conf $HOME/.tmux.conf

}

main
