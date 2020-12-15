#!/bin/zsh
DPATH="$HOME/.dotfiles"
$DPATH/scripts/lnfilepath.sh $DPATH/home/Library/Fonts/*.ttf $HOME/Library/Fonts

$DPATH/scripts/lnfilepath.sh $DPATH/home/.* $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/*.vim $HOME/.config/nvim
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/plugins/*.vim $HOME/.config/nvim/plugins
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/*.lua $HOME/.config/nvim/lua
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/crystalline_statusline $HOME/.config/nvim/plugged/vim-crystalline/autoload/crystalline/theme/crystalline_statusline.vim
