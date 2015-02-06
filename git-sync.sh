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
# Git
cp ~/.gitconfig ./
# MPD
[[ ! -d ./.mpd ]] && mkdir ./.mpd
cp ~/.mpd/mpd.conf ./.mpd
# NCMPCPP
[[ ! -d ./.ncmpcpp ]] && mkdir ./.ncmpcpp
cp ~/.ncmpcpp/config ./.ncmpcpp
# rTorrent
cp ~/.rtorrent.rc ./
# Scripts
cp -R ~/.scripts ./
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
