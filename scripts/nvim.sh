#!/usr/bin/env bash

function main() {

  echo "+---------------------------------+"
  echo "|        Installing NeoVim        |"
  echo "+---------------------------------+"

  brew install --HEAD neovim

  # Node Version Manager
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvmexport NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

  # SDKman - JVM related stuff
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

  # Ruby Environment Manager
  eval "$(rbenv init -)"

  # Python Environment Manager
  eval "$(pyenv init -)"

  # Golnag Version Manager
  [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

  gem install neovim
  pip install neovim
  pip3 install neovim
  npm install -g neovim

  gem install solargraph
  npm install -g bash-language-server write-good markdownlint-cli eslint tslint shellcheck
  go get -u golang.org/x/tools/cmd/gopls
  pip3 install python-language-server pylint

  curl https://languagetool.org/download/LanguageTool-stable.zip --output languagetool.zip \
    && unzip languagetool.zip -d $HOME/.config/nvim/ \
    && rm -rf languagetool.zip \
    && chmod +x $DPATH/nvim/languagetool.sh \
    && ln -fvs $DPATH/nvim/languagetool.sh /usr/local/bin/languagetool

  curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  mkdir -p $HOME/.config/nvim
  ln -fvs $DPATH/nvim/init.vim $HOME/.config/nvim/init.vim
  ln -fvs $DPATH/nvim/keybindings.vim $HOME/.config/nvim/keybindings.vim
  ln -fvs $DPATH/nvim/plugins.vim $HOME/.config/nvim/plugins.vim
  ln -fvs $DPATH/nvim/settings.vim $HOME/.config/nvim/settings.vim
  ln -fvs $DPATH/nvim/ui.vim $HOME/.config/nvim/ui.vim
  ln -fvs $DPATH/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json

  nvim -i NONE -c PlugInstall -c quitall

}

main

