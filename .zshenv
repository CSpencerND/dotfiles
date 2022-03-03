#!/bin/zsh

# XDG Compliance
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# System Directiories
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

# Misc PATH
export PATH="$PATH:$HOME/.local/statusbar"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/bin/polyscr"
export PATH="$PATH:$HOME/.config/nvim/utils/bin"
# export PATH="$PATH:$HOME/.local/share/npm/lib/node_modules/.bin"
# export PATH="$PATH:$HOME/node_modules/.bin"

# GDK
export GDK_SCALE=1.5
export GDK_DPI_SCALE=0.75

# -------------------------- Cleanup Home -------------------------------------

# Atom
export ATOM_HOME="$XDG_DATA_HOME"/atom
export ATOM_CONFIG="$XDG_CONFIG_HOME"/Atom
export ATOM_CACHE="$XDG_CACHE_HOME"/atom

# Cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"

# Conda
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export PATH="$HOME/miniconda3/condabin:$PATH" # can't be changed?
export PATH="$HOME/miniconda3/bin:$PATH" # can't be changed?

# Node / NPM
export PATH="$PATH:$HOME/.local/share/npm/bin"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# export NPM_CONFIG_PREFIX="$HOME"/node_modules
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME"/npm
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history 

# Misc
export GNUPGHOME="$XDG_DATA_HOME"/gnupg #gpg --homedir "$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export PATH="$XDG_DATA_HOME/go/bin:$PATH"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export JAVA_FONTS=/usr/share/fonts/TTF
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export TUXTYPE_CONF="$XDG_CONFIG_HOME/tuxtype/settings.txt"
# export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export MYVIMRC=XDG_CONFIG_HOME/nvim/init.lua
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export STACK_ROOT="$XDG_DATA_HOME"/stack
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc 
export SSB_HOME="$XDG_DATA_HOME"/zoom
# export ALSA_CONFIG_DIR="$XDG_CONFIG_HOME/alsa/asoundrc"

#zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"
export PATH="$PATH:$XDG_CONFIG_HOME/zsh/"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
HIST_STAMPS=mm/dd/yyyy
HISTSIZE=10000
SAVEHIST=10000

# -----------------------------------------------------------------------------

# Default Apps
export VISUAL='lvim'
export EDITOR=$VISUAL
export SUDO_EDITOR=$VISUAL
export TERMINAL="kitty"
export COLORTERM="truecolor"
# export MANPAGER='lvim +Man!'
# export MANWIDTH=999
# export PAGER="less"

# colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESSHISTFILE=-

# -----------------------------------------------------------------------------

unclutter --timeout 3 -b
