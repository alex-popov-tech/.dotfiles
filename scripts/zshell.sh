#!/usr/bin/env bash

function main() {

  echo "+---------------------------------+"
  echo "|        Installing Zshell        |"
  echo "+---------------------------------+"
  brew install zsh

  OMZ_PATH=$HOME/.oh-my-zsh
  CUSTOM_PATH=$OMZ_PATH/custom
  CUSTOM_PLUGINS_PATH=$CUSTOM_PATH/plugins
  CUSTOM_THEMES_PATH=$CUSTOM_PATH/themes

  [ ! -d "$OMZ_PATH" ] && \
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

  [ ! -d "$CUSTOM_PLUGINS_PATH/zsh-syntax-highlighting" ] && \
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $CUSTOM_PLUGINS_PATH/zsh-syntax-highlighting

  [ ! -d "$CUSTOM_PLUGINS_PATH/zsh-autosuggestions" ] && \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $CUSTOM_PLUGINS_PATH/zsh-autosuggestions

  [ ! -d "$CUSTOM_PLUGINS_PATH/zsh-completions" ] && \
    git clone --depth=1 https://github.com/zsh-users/zsh-completions.git $CUSTOM_PLUGINS_PATH/zsh-completions

[ ! -d "$CUSTOM_THEMES_PATH/powerlevel9k" ] && \
    git clone --depth=1 https://github.com/bhilburn/powerlevel9k.git $CUSTOM_THEMES_PATH/powerlevel9k

  ln -fsv $DPATH/zshell/zsh_env $HOME/.zsh_env
  ln -fsv $DPATH/zshell/zsh_ohmyzsh $HOME/.zsh_ohmyzsh
  ln -fsv $DPATH/zshell/zsh_prompt $HOME/.zsh_prompt
  ln -fsv $DPATH/zshell/zsh_aliases $HOME/.zsh_aliases
  ln -fsv $DPATH/zshell/zsh_functions $HOME/.zsh_functions
  ln -fsv $DPATH/zshell/zsh_langs $HOME/.zsh_langs
  ln -fsv $DPATH/zshell/zsh_commands $HOME/.zsh_commands
  ln -fsv $DPATH/zshell/zshrc $HOME/.zshrc

}

main
