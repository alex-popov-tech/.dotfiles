#  zmodload zsh/zprof
#  PS4=$'%D{%M%S%.} %N:%i> '
#  exec 3>&2 2>$HOME/startlog.$$
#  setopt xtrace prompt_subst

# Enable Powerlevel10k instant prompt. Should stay close to the top of zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof
source $HOME/.zsh/env
source $HOME/.zsh/prompt
source $HOME/.zsh/settings
source $HOME/.zsh/fzf
source $HOME/.zsh/style
source $HOME/.zsh/plugins
source $HOME/.zsh/langs
source $HOME/.zsh/functions
source $HOME/.zsh/aliases

#  unsetopt xtrace
#  exec 2>&3 3>&-; zprof > ~/zshprofile$(date +'%s')

#  PATH="/Users/alexanderpopov/perl5/bin${PATH:+:${PATH}}"; export PATH;

#  PERL5LIB="/Users/alexanderpopov/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#  PERL_LOCAL_LIB_ROOT="/Users/alexanderpopov/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#  PERL_MB_OPT="--install_base \"/Users/alexanderpopov/perl5\""; export PERL_MB_OPT;

