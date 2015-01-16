typeset -aU path
path=(
      $HOME/.scripts
      $HOME/.bin
      $path
     )

HISTFILE=~/.zhistory

export PAGER=less
export EDITOR=vim
export BROWSER=firefox

umask 022

[[ $TERM == linux ]] && setterm -blength 0
