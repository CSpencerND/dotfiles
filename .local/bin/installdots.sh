#!/bin/bash
echo "This script hasn't been tested. Use at your own risk."

rate-mirrors --allow-root arch | tee /etc/pacman.d/mirrorlist
sudo pacman -S archlinux-keyring
sudo pacman -Syu
sudo pacman -S --needed paru-bin
sudo paru -S --needed - <(curl -s https://raw.githubusercontent.com/CSpencerND/dotfiles/main/Documents/backup/pkgs/all-pkgs)

chsh -s "$(which zsh)"

alias backup='/usr/bin/git --git-dir=$HOME/.backup/ --work-tree=$HOME'
git clone --bare git@github.com:CSpencerND/dotfiles.git "$HOME"/.backup

mkdir -p .config-backup && \
backup checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

backup checkout
backup config --local status.showUntrackedFiles no
