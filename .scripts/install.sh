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
  asdf install nodejs lts
  asdf global nodejs lts

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
  asdf install python 3.11.1
  asdf global python 3.11.1

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

  echo
  echo "+------------------------------+"
  echo "|      Installing Golang       |"
  echo "+------------------------------+"
  echo
  asdf plugin-add golang
  asdf install golang 1.19
  asdf global golang 1.19

  asdf reshim
}

function software() {

  touch $HOME/.bash_profile

  echo
  echo "+-----------------------------------+"
  echo "|        Installing Homebrew        |"
  echo "+-----------------------------------+"
  echo
  xcode-select --install
  # [ m1 ] insure required dir in path
  export PATH=/opt/homebrew/bin:$PATH
  is_arm64() {
      test "$(uname -m)" = "arm64" 
  }
  if is_arm64; then
    local homebrew_bin="/opt/homebrew/bin"
    if ! cat /etc/paths | grep -q "${homebrew_bin}"; then
      echo "setting up homebrew binary path for gui apps"
      echo -e "${homebrew_bin}\n$(cat /etc/paths)" | sudo tee /etc/paths > /dev/null
    fi
  fi

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo
  echo "+-------------------------------+"
  echo "|        Installing asdf        |"
  echo "+-------------------------------+"
  echo
  if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf
  fi
  cd $HOME/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  cd --
  source $HOME/.asdf/asdf.sh

  echo
  echo "+-----------------------------------+"
  echo "|        Installing Software        |"
  echo "+-----------------------------------+"
  echo

  cp -f $DPATH/.other/fonts/*.ttf $HOME/Library/Fonts

  brew bundle install --file $DPATH/Brewfile

  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  curl https://cht.sh/:cht.sh > ./cht.sh
  chmod +x ./cht.sh
  # mv ./cht.sh /usr/local/bin/
  mv ./cht.sh /opt/homebrew/bin/

  echo
  echo "+---------------------------------+"
  echo "|          Installing Zi          |"
  echo "+---------------------------------+"
  echo
  if [ ! -d "$HOME/.zi" ]; then
    command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
      print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
      print -P "%F{160}▓▒░ The clone has failed.%f%b"
  fi

  echo
  echo "+---------------------------------+"
  echo "|     Installing Neovim tools     |"
  echo "+---------------------------------+"
  echo
  if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/" ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
  fi
  # gem install neovim
  # pip install neovim pynvim
  # pip3 install neovim pynvim
  # npm install -g neovim

}

main
