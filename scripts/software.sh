#!/usr/bin/env bash

function main() {

  echo "+-----------------------------------+"
  echo "|        Installing Software        |"
  echo "+-----------------------------------+"

  brew install htop \
    watch \
    grep \
    openssh \
    rsync \
    ssh-copy-id

  sudo /usr/bin/gem install colorls

  brew cask install iterm2 \
    google-chrome firefox \
    transmission \
    the-unarchiver \
    macs-fan-control \
    dropbox \
    docker \
    telegram skype \
    android-file-transfer \
    vlc \
    gitkraken \
    tunnelblick \
    flux toggl karabiner-elements

  brew tap caskroom/fonts && brew cask install font-hack-nerd-font

  ITERM_PROFILES_PATH="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
  mkdir -p "$ITERM_PROFILES_PATH"
  ln -fvs $DPATH/terminal/profile "$ITERM_PROFILES_PATH/profile"

  KARABINER_PATH="$HOME/.config/karabiner"
  mkdir -p "$KARABINER_PATH"
  ln -fsv $DPATH/karabiner/karabiner.json $KARABINER_PATH/karabiner.json

  tic $DPATH/terminal/xterm-256color-italic.terminfo

  mas lucky Magnet
  mas lucky CopyClip
  mas lucky Keynote
  mas lucky Pages

}

main
