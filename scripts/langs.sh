#!/usr/bin/env bash

function main() {

  echo "+---------------------------------+"
  echo "|        Installing NodeJS        |"
  echo "+---------------------------------+"
  nvm install node
  npm install -g yarn

  echo "+-------------------------------+"
  echo "|        Installing Java        |"
  echo "+-------------------------------+"
  sdk install java 9.0.4-open

  echo "+-------------------------------+"
  echo "|        Installing Ruby        |"
  echo "+-------------------------------+"
  rbenv install 2.6.3
  rbenv global 2.6.3
  rbenv rehash

  echo "+---------------------------------+"
  echo "|        Installing Python        |"
  echo "+---------------------------------+"
  CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install 3.7.3
  CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install 2.7.15
  pyenv global 2.7.15 3.7.3

  echo "+---------------------------------+"
  echo "|        Installing Golang        |"
  echo "+---------------------------------+"
  if [[ ! "$(where go)" =~ "gvm" ]]; then
    brew install go
    gvm install go1.12.5
    gvm use go1.12.5 --default
    brew uninstall go
  fi
}

main
