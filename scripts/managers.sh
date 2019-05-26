#!/usr/bin/env bash

function main() {

  touch $HOME/.bash_profile
  if ! which brew > /dev/null; then
    echo "+-----------------------------------+"
    echo "|        Installing Homebrew        |"
    echo "+-----------------------------------+"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    export PATH=$HOME/bin:/usr/local/bin:$PATH
  else
    brew update
  fi
  brew upgrade

  echo "+------------------------------------------+"
  echo "|        Installing Macos App Store        |"
  echo "+------------------------------------------+"
  brew install mas

  echo "+-----------------------------------------------+"
  echo "|        Installing Node Version Manager        |"
  echo "+-----------------------------------------------+"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

  echo "+--------------------------------------------------+"
  echo "|        Installing JVM Environment Manager        |"
  echo "+--------------------------------------------------+"
  curl -s "https://get.sdkman.io" | bash

  echo "+---------------------------------------------------+"
  echo "|        Installing Ruby Environment Manager        |"
  echo "+---------------------------------------------------+"
  brew install rbenv ruby-build

  echo "+-----------------------------------------------------+"
  echo "|        Installing Python Environment Manager        |"
  echo "+-----------------------------------------------------+"
  brew install readline xz pyenv

  echo "+-------------------------------------------------+"
  echo "|        Installing Golang Version Manager        |"
  echo "+-------------------------------------------------+"
  brew install mercurial
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
}

main

