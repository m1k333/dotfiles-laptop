#General options
#
export XAUTHORITY=$HOME/.Xauthority
setopt notify
ulimit -c 0

#Enter interactive mode after running a command
#
if [[ $1 == eval ]]; then
   "$@"
   set --
fi
alias zshi='zsh -is eval'

#Editor
#
export KEYTIMEOUT=1
bindkey -v
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'g~' vi-oper-swap-case
bindkey -a G end-of-buffer-or-history
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^G' what-cursor-position

#History
#
HISTSIZE=30000
SAVEHIST=30000
setopt appendhistory
setopt HIST_IGNORE_DUPS
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

#Autocompletion
#
autoload -Uz compinit && compinit
compinit -d $HOME/.zcompdump
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt extendedglob
setopt completealiases
setopt no_case_glob

#Prompt
#
setopt prompt_subst
hash0="%#"
dirind="[%~]-"

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

#Aliases
#
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
