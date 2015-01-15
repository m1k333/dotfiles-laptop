#!/bin/bash

## Initializations
echo "Starting sync..."
[[ ! -d ./.config ]] && mkdir ./.config

## Copy files
# Emacs
[[ ! -d ./.emacs.d ]] && mkdir ./.emacs.d
cp ~/.emacs.d/init.el ./.emacs.d
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
# XMonad
[[ ! -d ./.xmonad ]] && mkdir ./.xmonad
cp ~/.xmonad/xmonad.hs ./.xmonad
cp ~/.xmobarrc ./.xmobarrc
[[ ! -d ./.xmonad/lib ]] && mkdir ./.xmonad/lib
cp -R ~/.xmonad/lib/* ./.xmonad/lib
rm ./.xmonad/lib/XMonad/Layout/BinarySpacePartition.{hi,o}
# Xorg
cp ~/.Xresources ./
# Zathura
[[ ! -d ./.config/zathura ]] && mkdir ./.config/zathura
cp ~/.config/zathura/zathurarc ./.config/zathura
# ZSH
cp ~/.zshrc ./
cp ~/.zshenv ./

## Sync files
git add -A
git commit -m "Update at $(date)"
git push
echo "Finished sync."
