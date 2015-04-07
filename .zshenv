typeset -aU path
path=(
     $HOME/.scripts
     $HOME/.bin
     $path
     )

export PAGER=less
export EDITOR=vim
export BROWSER=firefox

umask 022
