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
    ssh-copy-id \
    bat \
    prettyping \
    the_silver_searcher ripgrep

  sudo /usr/bin/gem install colorls

  brew cask install iterm2 \
    google-chrome firefox \
    alfred \
    transmission \
    the-unarchiver \
    macs-fan-control \
    dropbox \
    steam \
    docker \
    telegram skype zoom \
    android-file-transfer \
    vlc \
    gitkraken \
    tunnelblick \
    flux \
    toggl \
    blockblock \
    mysqlworkbench \
    teamviewer \
    ledger-live \
    vanilla \
    arduino \
    boom-3d \
    karabiner-elements \
    intellij-idea-ce \
    expressvpn

  brew tap caskroom/fonts
  brew cask install font-hack-nerd-font font-fira-code

  ITERM_PROFILES_PATH="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
  mkdir -p "$ITERM_PROFILES_PATH"
  ln -fvs $DPATH/terminal/profile.json "$ITERM_PROFILES_PATH/profile"

  KARABINER_PATH="$HOME/.config/karabiner"
  mkdir -p "$KARABINER_PATH"
  ln -fsv $DPATH/karabiner/karabiner.json $KARABINER_PATH/karabiner.json

  tic $DPATH/terminal/xterm-256color-italic.terminfo

  mas lucky Magnet
  mas lucky Keynote
  mas lucky Pages

}

main
