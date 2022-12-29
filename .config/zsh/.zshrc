#!/bin/zsh

#Cuz it looks nice :)
# colorscript random

alias clear='clear -x; echo; echo; seq 1 $(tput cols) | sort -R | spark | lolcat; echo; echo'
clear

# Enable colors and change prompt:
autoload -U colors && colors

# Configure color-scheme
export COLOR_SCHEME=dark # dark/light

# -----------------------------------------------------------------------------

# Default Apps
export VISUAL="lvim" || "nvim"
export EDITOR=$VISUAL
export SUDO_EDITOR=$VISUAL
export TERMINAL="kitty"
export COLORTERM="truecolor"
export MANPAGER="'$VISUAL' +Man!"
export MANWIDTH=999
export PAGER="less"
# export PAGER=/usr/local/bin/moar

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

# Load aliases and shortcuts if existent:
[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"

# ZSH completion system
zmodload zsh/complist
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Keybinds
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -s '^o' 'ranger^M'
bindkey -s '^l' 'clear^M'
bindkey -s '^b' 'tmux^M'

# enable terminal linewrap
setterm -linewrap on 2> /dev/null

# colorize ls
[ -x /usr/bin/dircolors ] && eval "$(dircolors -b)"

# ------------------------------- SETTINGS ------------------------------------
setopt AUTO_CD
setopt BEEP
#setopt CORRECT
setopt HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
# setopt INC_APPEND_HISTORY
setopt INTERACTIVE_COMMENTS
setopt MAGIC_EQUAL_SUBST
setopt NO_NO_MATCH
setopt NOTIFY
setopt NUMERIC_GLOB_SORT
setopt PROMPT_SUBST
setopt SHARE_HISTORY

# -------------------------------- FUNCTIONS ----------------------------------
# Use lf to switch directories and bind it to ctrl-o
# lfcd () {
#     tmp="$(mktemp)"
#     lf -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp"
#         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }
# bindkey -s '^o' 'lfcd\n'

find() {
	if [ $# = 1 ]
	then
		command find . -iname "*$@*"
	else
		command find "$@"
	fi
}

### EXTRACTION
ext ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ext()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### GIT
# lazygit() {
# 	USAGE="
# lazygit [OPTION]... <msg>
#
#     GIT but lazy
#
#     Options:
#         --fixup <commit>        runs 'git commit --fixup <commit> [...]'
#         --amend                 runs 'git commit --amend --no-edit [...]'
#         -f, --force             runs 'git push --force-with-lease [...]'
#         -h, --help              show this help text
# "
# 	while [ $# -gt 0 ]
# 	do
# 		key="$1"
#
# 		case $key in
# 			--fixup)
# 				COMMIT="$2"
# 				shift # past argument
# 				shift # past value
# 				;;
# 			--amend)
# 				AMEND=true
# 				shift # past argument
# 				;;
# 			-f|--force)
# 				FORCE=true
# 				shift # past argument
# 				;;
# 			-h|--help)
# 				echo "$USAGE"
# 				EXIT=true
# 				break
# 				;;
# 			*)
# 				MESSAGE="$1"
# 				shift # past argument
# 				;;
# 		esac
# 	done
# 	unset key
# 	if [ -z "$EXIT" ]
# 	then
# 		git status .
# 		git add .
# 		if [ -n "$AMEND" ]
# 		then
# 			git commit --amend --no-edit
# 		elif [ -n "$COMMIT" ]
# 		then
# 			git commit --fixup "$COMMIT"
# 			GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash "$COMMIT"^
# 		else
# 			git commit -m "$MESSAGE"
# 		fi
# 		git push origin HEAD $([ -n "$FORCE" ] && echo '--force-with-lease')
# 	fi
# 	unset USAGE COMMIT MESSAGE AMEND FORCE
# }

glog() {
	setterm -linewrap off 2> /dev/null

	git --no-pager log --all --color=always --graph --abbrev-commit --decorate --date-order \
		--format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' "$@" \
		| sed -E \
			-e 's/\|(\x1b\[[0-9;]*m)+\\(\x1b\[[0-9;]*m)+ /├\1─╮\2/' \
			-e 's/(\x1b\[[0-9;]+m)\|\x1b\[m\1\/\x1b\[m /\1├─╯\x1b\[m/' \
			-e 's/\|(\x1b\[[0-9;]*m)+\\(\x1b\[[0-9;]*m)+/├\1╮\2/' \
			-e 's/(\x1b\[[0-9;]+m)\|\x1b\[m\1\/\x1b\[m/\1├╯\x1b\[m/' \
			-e 's/╮(\x1b\[[0-9;]*m)+\\/╮\1╰╮/' \
			-e 's/╯(\x1b\[[0-9;]*m)+\//╯\1╭╯/' \
			-e 's/(\||\\)\x1b\[m   (\x1b\[[0-9;]*m)/╰╮\2/' \
			-e 's/(\x1b\[[0-9;]*m)\\/\1╮/g' \
			-e 's/(\x1b\[[0-9;]*m)\//\1╯/g' \
			-e 's/^\*|(\x1b\[m )\*/\1⎬/g' \
			-e 's/(\x1b\[[0-9;]*m)\|/\1│/g' \
		| command less -r $([ $# -eq 0 ] && echo "+/[^/]HEAD")

	setterm -linewrap on 2> /dev/null
}

# ------------------------------- ZSH PLUGINS ---------------------------------
# Plugin source helper
_source_plugin() {
	local plugin_name="$1"
	for basedir in $HOME/.local/share/zsh/plugins # /usr/share
	do
		plugin="$basedir/$plugin_name/$plugin_name.zsh"
		[ -f "$plugin" ] && source "$plugin" && return 0
	done
	echo "\033[33m[ ! ]\033[0m ZSH ${plugin_name#zsh-} not installed"
	return 1
}

# ZSH Autosuggestions
_source_plugin zsh-autosuggestions && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
_source_plugin alias-tips

# ZSH Syntax Highlighting
if _source_plugin zsh-syntax-highlighting
then
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
	ZSH_HIGHLIGHT_STYLES[default]=none
	ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[path]=underline
	ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[command-substitution]=none
	ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[process-substitution]=none
	ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[assign]=none
	ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
	ZSH_HIGHLIGHT_STYLES[named-fd]=none
	ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
	ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
	ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi

unset -f _source_plugin

[ -f ~/usr/bin/fzf ] && source ~/usr/bin/fzf

# -------------------------------- -------- -----------------------------------
# [ -f "$ZDOTDIR/zprompt.sh" ] && source "$ZDOTDIR/zprompt.sh"
eval "$(lua ~/.local/share/zsh/plugins/z.lua/z.lua --init zsh)"
eval "$(starship init zsh)"

# fnm
eval "$(fnm env)"

export PYTHONSTARTUP=~/.config/pyrc
