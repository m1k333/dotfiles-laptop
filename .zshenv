# ~/.zshenv
# 2014-06-27

#-----------#
# Variables #
# ----------#

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

#---------------#
# file settings #
#---------------#

umask 022

#----------#
# no beeep #
# ---------#

[[ $TERM == linux ]] && setterm -blength 0
