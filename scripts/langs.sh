#!/usr/bin/env bash
set -e

function main() {

  echo "+---------------------------------+"
  echo "|        Installing NodeJS        |"
  echo "+---------------------------------+"
  nvm install --lts
  nvm use --lts
  nvm alias default 'lts/*'
  npm install -g yarn

  echo "+-------------------------------+"
  echo "|        Installing Java        |"
  echo "+-------------------------------+"
  sdk install java 8.0.232.j9-adpt

  echo "+-------------------------------+"
  echo "|        Installing Ruby        |"
  echo "+-------------------------------+"
  latestruby=$(rbenv install -l | grep -v - | tail -1 | awk '{$1=$1};1')
  rbenv install $latestruby
  rbenv global $latestruby
  rbenv rehash

  echo "+---------------------------------+"
  echo "|        Installing Python        |"
  echo "+---------------------------------+"
  latestpython=$(pyenv install -l | grep -v - | tail -1 | awk '{$1=$1};1')
  CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install $latestpython
  CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install 2.7.15
  pyenv global 2.7.15 $latestpython
}

main
