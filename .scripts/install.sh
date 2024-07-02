#!/usr/bin/env bash

DPATH=$HOME/.dotfiles

print_header() {
  local msg="$1"
  echo "=================================================="
  echo "== $msg"
  echo "=================================================="
}

sparse_clone_and_copy() {
  local repo_url="$1"
  local checkout_path="$2"
  local target_dir="$3"
  local tmp_dir=$(mktemp -d)

  print_header "Cloning repository: $repo_url"
  git clone --depth 1 --filter=blob:none --sparse "$repo_url" "$tmp_dir"

  print_header "Setting sparse checkout for path: $checkout_path"
  cd "$tmp_dir"
  git sparse-checkout set "$checkout_path"

  print_header "Copying $checkout_path to $target_dir"
  cp -r "$tmp_dir/$checkout_path" "$target_dir"

  print_header "Cleaning up temporary directory"
  cd "$OLDPWD"
  rm -rf "$tmp_dir"

  print_header "Done!"
}

function main() {

  echo
  read -p "Install software? Y/N" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    software
    sparse_clone_and_copy "https://github.com/ryanoasis/nerd-fonts.git" "patched-fonts/JetBrainsMono/Ligatures" "$PWD/fonts"
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

  defaults write -g AppleShowAllFiles -bool true

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
  asdf install nodejs 20.2.0
  asdf global nodejs 20.2.0

  echo
  echo "+-------------------------------+"
  echo "|        Installing Java        |"
  echo "+-------------------------------+"
  echo
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf install java adoptopenjdk-11.0.18+10
  asdf global java adoptopenjdk-11.0.18+10

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
  echo "|      Installing Golang       |"
  echo "+------------------------------+"
  echo
  asdf plugin-add golang
  asdf install golang 1.22.4
  asdf global golang 1.22.4

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

  curl https://cht.sh/:cht.sh > /opt/homebrew/bin/cht.sh
  chmod +x /opt/homebrew/bin/cht.sh

}

main
