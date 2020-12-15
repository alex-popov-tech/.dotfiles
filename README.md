# Dotfiles

* cron backup for [lastpass](./scripts/backup/lastpass.sh) and [keybaseio](./scripts/backup/keybase.sh)
  * how to use ```
      0 * */3 * * $HOME/.dotfiles/backup/mailOnErr.sh $HOME/.dotfiles/backup/lastpass.sh
      0 * */3 * * $HOME/.dotfiles/backup/mailOnErr.sh $HOME/.dotfiles/backup/keybase.sh
    ```

## Installation

Notes:

* for installing apps from `mas` you should be logged in Mac Apple store,
otherwise there will be warning while installation
* you might want to add some apps to startup after installation

## Useful links

* how to configure `mail` for crontab gmail on macos https://gist.github.com/giovanigenerali/39efe8760f84ed74b44a31be1ace27e7

### TODO

* rewrite time tracking alfred plugin to be able to start timer for project without searchin for them
* suggested [software](https://github.com/jaywcjlove/awesome-mac)
  * [better touch tool](https://folivora.ai)
  * [console player](https://cmus.github.io/#features)
