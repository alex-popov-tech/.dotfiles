#!/bin/zsh
DPATH="$HOME/.dotfiles"
$DPATH/lnfilepath.sh $DPATH/terminal/alacritty.yml $HOME/.alacritty.yml
$DPATH/lnfilepath.sh $DPATH/terminal/*.ttf $HOME/Library/Fonts
$DPATH/lnfilepath.sh $DPATH/terminal/zshell/.zsh* $HOME
$DPATH/lnfilepath.sh $DPATH/tmux/.tmux* $HOME

$DPATH/lnfilepath.sh $DPATH/nvim/*.vim $HOME/.config/nvim
$DPATH/lnfilepath.sh $DPATH/nvim/plugins/*.vim $HOME/.config/nvim/lua
$DPATH/lnfilepath.sh $DPATH/nvim/crystalline_statusline $HOME/.config/nvim/plugged/vim-crystalline/autoload/crystalline/theme/crystalline_statusline.vim
$DPATH/lnfilepath.sh $DPATH/nvim/lua/*.lua $HOME/.config/nvim/lua

$DPATH/lnfilepath.sh $DPATH/configs/.* $HOME
