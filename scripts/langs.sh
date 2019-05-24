#!/usr/bin/env bash

function main() {

  echo "+------------------------------------------+"
  echo "|        Installing NodeJS (latest)        |"
  echo "+------------------------------------------+"
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install node
  npm install -g yarn

  echo "+---------------------------------------------+"
  echo "|        Installing Java 9.0.4 OpenJDK        |"
  echo "+---------------------------------------------+"
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install java 9.0.4-open

  echo "+-------------------------------------+"
  echo "|        Installing Ruby 2.6.3        |"
  echo "+-------------------------------------+"
  rbenv install 2.6.3
  rbenv global 2.6.3
  rbenv rehash

  echo "+---------------------------------------+"
  echo "|        Installing Python 3.7.3        |"
  echo "+---------------------------------------+"
  CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install 3.7.3
  CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install 2.7.15
  pyenv global 2.7.15 3.7.3

  echo "+----------------------------------------+"
  echo "|        Installing Golang 1.12.5        |"
  echo "+----------------------------------------+"
  gvm install go1.12.5
  gvm use go1.12.5 --default
}

main
