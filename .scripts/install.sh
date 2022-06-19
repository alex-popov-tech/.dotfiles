#!/usr/bin/env bash

DPATH=$HOME/.dotfiles

function main() {

  echo
  read -p "Install software? Y/N" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    software
  fi

  echo
  read -p "Install langs? Y/N" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    langs
  fi

  echo
  echo "+-------------------------------+"
  echo "|        Linking Configs        |"
  echo "+-------------------------------+"
  echo
  brew install stow
  $DPATH/.scripts/linkconfigs.sh

}

function langs() {
  echo
  echo "+---------------------------------+"
  echo "|        Installing NodeJS        |"
  echo "+---------------------------------+"
  echo
  brew install gpg tar
  asdf plugin-add nodejs
  bash $HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf install nodejs 16.13.0
  asdf global nodejs 16.13.0

  echo
  echo "+-------------------------------+"
  echo "|        Installing Java        |"
  echo "+-------------------------------+"
  echo
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf install java adoptopenjdk-openj9-large_heap-8.0.282+8.openj9-0.24.0
  asdf global java adoptopenjdk-openj9-large_heap-8.0.282+8.openj9-0.24.0

  echo
  echo "+---------------------------------+"
  echo "|        Installing Python        |"
  echo "+---------------------------------+"
  echo
  asdf plugin-add python
  asdf install python 3.9.0
  asdf install python 2.7.13
  asdf global python 2.7.13 3.9.0

  echo
  echo "+-------------------------------+"
  echo "|        Installing Ruby        |"
  echo "+-------------------------------+"
  echo
  asdf plugin-add ruby
  asdf install ruby 2.7.0
  asdf global ruby 2.7.0

  echo
  echo "+------------------------------+"
  echo "|        Installing Lua        |"
  echo "+------------------------------+"
  echo
  asdf plugin-add lua
  asdf install lua 5.3.5
  asdf global lua 5.3.5

  echo
  echo "+------------------------------+"
  echo "|       Installing Rust        |"
  echo "+------------------------------+"
  echo
  asdf plugin-add rust
  asdf install rust stable
  asdf global rust stable

  asdf reshim
}

function software() {

  touch $HOME/.bash_profile

  echo
  echo "+-----------------------------------+"
  echo "|        Installing Homebrew        |"
  echo "+-----------------------------------+"
  echo
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo
  echo "+-------------------------------+"
  echo "|        Installing asdf        |"
  echo "+-------------------------------+"
  echo
  if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf
    cd $HOME/.asdf
    git checkout "$(git describe --abbrev=0 --tags)"
    cd --
  fi
  source $HOME/.asdf/asdf.sh

  echo
  echo "+-----------------------------------+"
  echo "|        Installing Software        |"
  echo "+-----------------------------------+"
  echo
  cp -f $DPATH/.fonts/*.ttf $HOME/Library/Fonts
  brew bundle install --file $DPATH/Brewfile
  sudo xcodebuild -license accept
  curl https://cht.sh/:cht.sh > ./cht.sh
  chmod +x ./cht.sh
  mv ./cht.sh /usr/local/bin/

  echo
  echo "+-------------------------------+"
  echo "|        Installing Tmux        |"
  echo "+-------------------------------+"
  echo
  asdf plugin-add tmux
  asdf install tmux 3.1b
  asdf global tmux 3.1b
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  else
    echo "Exists!"
  fi

  echo
  echo "+---------------------------------+"
  echo "|        Installing Zinit         |"
  echo "+---------------------------------+"
  echo
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  else
    echo "Exists!"
  fi

  brew install --head neovim
  echo
  echo "+---------------------------------+"
  echo "|     Installing NeoVim tools     |"
  echo "+---------------------------------+"
  echo
  gem install neovim
  pip install neovim pynvim
  pip3 install neovim pynvim
  npm install -g neovim

  if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
  fi
}

main
