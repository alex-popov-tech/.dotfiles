#!/bin/zsh
DPATH="$HOME/.dotfiles"

$DPATH/scripts/lnfilepath.sh $DPATH/home/.* $HOME

$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/efm-langserver/config.yaml $HOME/.config/efm-langserver/config.yaml

$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/*.lua $HOME/.config/nvim
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/*.lua $HOME/.config/nvim/lua
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/plugins/*.lua $HOME/.config/nvim/lua/plugins
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/lsp/*.lua $HOME/.config/nvim/lua/lsp
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/lsp/servers/*.lua $HOME/.config/nvim/lua/lsp/servers
