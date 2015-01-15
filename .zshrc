# ~/.zshrc
# 2014-06-27

#---------#
# startup #
#---------#

# Will grab the sudoer's Xauthority, preventing some issues with priveleges in X
export XAUTHORITY=$HOME/.Xauthority

#---------------#
# commands/jobs #
#---------------#

setopt notify
ulimit -c 0

# Run a command and then enter interactive mode
# using 'zsh -is eval XXXXXX'
if [[ $1 == eval ]]; then
   "$@"
   set --
fi
alias zshi='zsh -is eval '

#--------#
# editor #
#--------#

bindkey -v

export KEYTIMEOUT=1

bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'g~' vi-oper-swap-case
bindkey -a G end-of-buffer-or-history

bindkey -a u undo
bindkey -a '^R' redo

bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

bindkey '^G' what-cursor-position

#---------#
# history #
#---------#

HISTSIZE=30000
SAVEHIST=30000
setopt appendhistory
setopt HIST_IGNORE_DUPS
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

#----------------#
# autocompletion #
#----------------#

autoload -Uz compinit && compinit
compinit -d $HOME/.zcompdump

zstyle ':completion:*' menu select

setopt extendedglob
setopt completealiases
setopt no_case_glob
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#--------#
# Prompt #
#--------#

# Enable prompt substitutions
setopt prompt_subst

# The 'default' hash, which will be changed to show the mode if vi-keys are enabled
hash0="%#"

# PWD
dirind="[%~]-" # Current directory

# Prompt hash shows the vi-mode

precmd()
{
     phash="${hash0}"
     PS1="${dirind}${phash} "
}

zle-keymap-select()
{
    phash="${hash0}"
    [[ $KEYMAP = vicmd ]] && phash="/"
    PS1="${dirind}${phash} "
    () { return $__prompt_status }
    zle reset-prompt
}

zle-line-init()
{ typeset -g __prompt_status="$?" }

zle -N zle-keymap-select
zle -N zle-line-init


#----------#
# Aliases  #
#----------#

alias ls='ls -p --color=auto --group-directories-first'
alias ll='ls -ahlp --color=auto --group-directories-first'
alias la='ls -ap --color=auto --group-directories-first'
alias -g grep='grep --color=auto'
alias ..='cd ..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias su='su -'
alias sudo='sudo -E'
alias gksu='gksu -k'
alias gksudo='gksudo -k'

alias reboot='systemctl reboot'
alias poweroff='systemctl poweroff'
alias suspend='systemctl suspend'

alias tmat='tmux attach'
alias rtorrent='cd ~ && rtorrent'
