#!/bin/bash

## Initializations
echo "Starting sync..."
[[ ! -d ./.config ]] && mkdir ./.config

## Copy files
#archey3
cp ~/.archey3.cfg ./
#BSPWM
[[ ! -d ./.config/bspwm ]] && mkdir ./.config/bspwm
cp ~/.config/bspwm/bspwmrc ./.config/bspwm
cp ~/.config/bspwm/dmenu ./.config/bspwm
cp ~/.config/bspwm/panel ./.config/bspwm
cp ~/.config/bspwm/panel_bar ./.config/bspwm
cp ~/.config/bspwm/panel_profile ./.config/bspwm
cp ~/.config/bspwm/sxhkdrc ./.config/bspwm
# Emacs
[[ ! -d ./.emacs.d ]] && mkdir ./.emacs.d
cp ~/.emacs.d/init.el ./.emacs.d/init.el
cp ~/.emacs.d/keybindings.el ./.emacs.d/keybindings.el
cp -R ~/.emacs.d/elisp ./.emacs.d/
cp -R ~/.emacs.d/themes ./.emacs.d/
# Git
cp ~/.gitconfig ./
#MPD
[[ ! -d ./.config/mpd ]] && mkdir ./.config/mpd
[[ ! -d ./.config/mpd/playlists ]] && mkdir ./.config/mpd/playlists
cp ~/.config/mpd/mpd.conf ./.config/mpd
touch ./.config/mpd/{database,log,pid,state,sticker.sql}
#NCMPCPP
[[ ! -d ./.ncmpcpp ]] && mkdir ./.ncmpcpp
cp ~/.ncmpcpp/config ./.ncmpcpp
#bin
cp -R ~/bin ./
# Vim
cp ~/.vimrc ./
# Xorg
cp ~/.Xdefaults ./
cp ~/.xinitrc ./
# Zathura
[[ ! -d ./.config/zathura ]] && mkdir ./.config/zathura
cp ~/.config/zathura/zathurarc ./.config/zathura
# ZSH
cp ~/.zshrc ./
cp ~/.zshenv ./
cp ~/.zlogin ./

## Sync files
git add -A
git commit -m "Update at $(date)"
git push
echo "Finished sync."
