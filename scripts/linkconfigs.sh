#!/bin/zsh
DPATH="$HOME/.dotfiles"

$DPATH/scripts/lnfilepath.sh $DPATH/home/.default-npm-packages $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.default-python-packages $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.editorconfig $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.eslintrc $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.prettierrc $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.finicky.js $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.git* $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.tmux* $HOME
$DPATH/scripts/lnfilepath.sh $DPATH/home/.zsh* $HOME

$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/kitty/*.conf $HOME/.config/kitty

$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/*.lua $HOME/.config/nvim
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/*.lua $HOME/.config/nvim/lua
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/plugins/*.lua $HOME/.config/nvim/lua/plugins
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/lsp/*.lua $HOME/.config/nvim/lua/lsp
$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/lua/lsp/servers/*.lua $HOME/.config/nvim/lua/lsp/servers

$DPATH/scripts/lnfilepath.sh $DPATH/home/.config/nvim/vsnip/*.json $HOME/.config/vsnip

cp -vf $DPATH/home/Library/Fonts/* $HOME/Library/Fonts/
