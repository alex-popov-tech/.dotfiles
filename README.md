# Dotfiles

## What's inside

* MacOS settings based on
[Mathias dotfiles](https://github.com/mathiasbynens/dotfiles) repository.
* Languages:
  * nvm + NodeJS
  * sdkman + Java
  * pyenv + Python
  * rbenv + Ruby
  * gvm + Golang
* Software
* Global configs:
  * [gitconfig](./configs/gitconfig)
  * [gitignore](./configs/gitignore)
  * [editorconfig](./configs/editorconfig)
  * [eslintrc](./configs/eslintrc)
  * [tigrc](./configs/tigrc)
* [keyboardio layout](http://www.keyboard-layout-editor.com/#/gists/4782bb723fbd9c12adfc23d293e9af0c)
* Badass terminal - iterm2 + Powerlevel9k + Nerd Fonts + [Zshell](https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet) with plugins (e.g. [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git/)) and tools
![screenshot](files/terminal.jpg)
* NeoVim with bunch of plugins, color schemes and [cheatsheet](vim.md)
![screenhot1](files/nvim1.png)
![screenhot2](files/nvim2.png)
* Alfred with some customizations and [cheetsheet](alfred.md)

## Installation

Since we will be installing environment managers like `rbenv` and
settings MacOS it's required to reload your mac at some point of installation.
For this purposes installation process consists from two install scripts,
read below how to use them.

Notes:

* for installing apps from `mas` you should be logged in Mac Apple store,
otherwise there will be warning while installation
* you might want to add some apps to startup after installation

1. Install main stuff (managers, langs, software, etc)
   * `curl https://raw.githubusercontent.com/aleksanderpopov/.dotfiles/master/install.sh | bash`
2. (Optional) Setup some macos settings which require disabling [System Integrity Protection](https://christianvarga.com/how-to-delete-sleepimage-on-macos-high-sierra/)
   * > Restart your machine and hold down CMD + R to boot into recovery mode.
     > When that loads, go to Utilities - Terminal,
     > and enter the following to disable SIP:

      `csrutil disable; reboot`

   * When your machine starts back up run following script:

      `curl https://raw.githubusercontent.com/aleksanderpopov/.dotfiles/master/macos_optional.sh | bash`

   * Boot into recovery mode again and re-enable SIP:

      `csrutil enable; reboot`

   * When you're back into macos verify that SIP enabled and the sleepimage has a size of 0 bytes:

      `csrutil status; ls -la /private/var/vm`

## Additional customization

* you can use Gruvbox theme instead of default Solarized Dark using import `./terminal/gruvbox-dark.itermcolors`

### TODO

* define some aliases fow split and resize tmux/neovim
* rewrite time tracking alfred plugin to be able to start timer for project without searchin for them
* suggested [software](https://github.com/jaywcjlove/awesome-mac)
  * [better touch tool](https://folivora.ai)
  * [console player](https://cmus.github.io/#features)
  * mail clients?:

