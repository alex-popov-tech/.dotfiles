#!/bin/zsh
cd $HOME/.dotfiles

/bin/ls -d */ | xargs -n1 stow --restow

cd -
