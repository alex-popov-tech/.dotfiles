#!/usr/bin/env bash

function main() {

  echo "+---------------------------------+"
  echo "|        Installing NeoVim        |"
  echo "+---------------------------------+"

  ln -fvs $DPATH/nvim/nvim*/bin/nvim /usr/local/bin/nvim

  gem install neovim
  pip install neovim
  pip3 install neovim
  npm install -g neovim

  brew install shellcheck the_silver_searcher
  gem install solargraph
  npm install -g bash-language-server write-good markdownlint-cli eslint tslint
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

