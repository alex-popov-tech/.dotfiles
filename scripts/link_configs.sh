#!/usr/bin/env bash

function main() {

  echo "+-------------------------------+"
  echo "|        Linking Configs        |"
  echo "+-------------------------------+"

  ln -fvs $DPATH/configs/gitconfig $HOME/.gitconfig
  ln -fvs $DPATH/configs/gitignore $HOME/.gitignore
  ln -fvs $DPATH/configs/editorconfig $HOME/.editorconfig
  ln -fvs $DPATH/configs/eslintrc $HOME/.eslintrc

}

main
