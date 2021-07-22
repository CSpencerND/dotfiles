#!/bin/zsh

#Cuz it looks nice :)
colorscript random

# Load aliases and shortcuts if existent:
[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"
# export LC_CTYPE=en_US.UTF-8

# Enable colors and change prompt:
autoload -U colors && colors

# Configure color-scheme
COLOR_SCHEME=dark # dark/light


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
lazygit() {
	USAGE="
lazygit [OPTION]... <msg>

    GIT but lazy

    Options:
        --fixup <commit>        runs 'git commit --fixup <commit> [...]'
        --amend                 runs 'git commit --amend --no-edit [...]'
        -f, --force             runs 'git push --force-with-lease [...]'
        -h, --help              show this help text
"
	while [ $# -gt 0 ]
	do
		key="$1"

		case $key in
			--fixup)
				COMMIT="$2"
				shift # past argument
				shift # past value
				;;
			--amend)
				AMEND=true
				shift # past argument
				;;
			-f|--force)
				FORCE=true
				shift # past argument
				;;
			-h|--help)
				echo "$USAGE"
				EXIT=true
				break
				;;
			*)
				MESSAGE="$1"
				shift # past argument
				;;
		esac
	done
	unset key
	if [ -z "$EXIT" ]
	then
		git status .
		git add .
		if [ -n "$AMEND" ]
		then
			git commit --amend --no-edit
		elif [ -n "$COMMIT" ]
		then
			git commit --fixup "$COMMIT"
			GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash "$COMMIT"^
		else
			git commit -m "$MESSAGE"
		fi
		git push origin HEAD $([ -n "$FORCE" ] && echo '--force-with-lease')
	fi
	unset USAGE COMMIT MESSAGE AMEND FORCE
}

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
	for basedir in $HOME/.local/share/zsh/plugins /usr/share
	do
		plugin="$basedir/$plugin_name/$plugin_name.zsh"
		[ -f "$plugin" ] && source "$plugin" && return 0
	done
	echo "\033[33m[ ! ]\033[0m ZSH ${plugin_name#zsh-} not installed"
	return 1
}

# ZSH Autosuggestions
_source_plugin zsh-autosuggestions && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

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

### GIT
# alias gp=gitpush
# alias gu=gitupdate
# # alias lbrynet='/opt/LBRY/resources/static/daemon/lbrynet'
# # alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
#
# gitpush() {
#     git add .
#     git commit -m "$*"
#     git pull
#     git push
# }
#
# gitupdate() {
#     eval "$(ssh-agent -s)"
#     ssh-add ~/.ssh/github
#     ssh -T git@github.com
# }

# -------------------------------- DEFAULTS -----------------------------------
# READNULLCMD=${PAGER:-/usr/bin/pager}

# # An array to note missing features to ease diagnosis in case of problems.
# typeset -ga debian_missing_features
#
# if [[ -z "${DEBIAN_PREVENT_KEYBOARD_CHANGES-}" ]] &&
#    [[ "$TERM" != 'emacs' ]]
# then
#
#     typeset -A key
#     key=(
#         BackSpace  "${terminfo[kbs]}"
#         Home       "${terminfo[khome]}"
#         End        "${terminfo[kend]}"
#         Insert     "${terminfo[kich1]}"
#         Delete     "${terminfo[kdch1]}"
#         Up         "${terminfo[kcuu1]}"
#         Down       "${terminfo[kcud1]}"
#         Left       "${terminfo[kcub1]}"
#         Right      "${terminfo[kcuf1]}"
#         PageUp     "${terminfo[kpp]}"
#         PageDown   "${terminfo[knp]}"
#     )
#
#     function bind2maps () {
#         local i sequence widget
#         local -a maps
#
#         while [[ "$1" != "--" ]]; do
#             maps+=( "$1" )
#             shift
#         done
#         shift
#
#         sequence="${key[$1]}"
#         widget="$2"
#
#         [[ -z "$sequence" ]] && return 1
#
#         for i in "${maps[@]}"; do
#             bindkey -M "$i" "$sequence" "$widget"
#         done
#     }
#
#     bind2maps emacs             -- BackSpace   backward-delete-char
#     bind2maps       viins       -- BackSpace   vi-backward-delete-char
#     bind2maps             vicmd -- BackSpace   vi-backward-char
#     bind2maps emacs             -- Home        beginning-of-line
#     bind2maps       viins vicmd -- Home        vi-beginning-of-line
#     bind2maps emacs             -- End         end-of-line
#     bind2maps       viins vicmd -- End         vi-end-of-line
#     bind2maps emacs viins       -- Insert      overwrite-mode
#     bind2maps             vicmd -- Insert      vi-insert
#     bind2maps emacs             -- Delete      delete-char
#     bind2maps       viins vicmd -- Delete      vi-delete-char
#     bind2maps emacs viins vicmd -- Up          up-line-or-history
#     bind2maps emacs viins vicmd -- Down        down-line-or-history
#     bind2maps emacs             -- Left        backward-char
#     bind2maps       viins vicmd -- Left        vi-backward-char
#     bind2maps emacs             -- Right       forward-char
#     bind2maps       viins vicmd -- Right       vi-forward-char
#
#     # Make sure the terminal is in application mode, when zle is
#     # active. Only then are the values from $terminfo valid.
#     if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#         function zle-line-init () {
#             emulate -L zsh
#             printf '%s' ${terminfo[smkx]}
#         }
#         function zle-line-finish () {
#             emulate -L zsh
#             printf '%s' ${terminfo[rmkx]}
#         }
#         zle -N zle-line-init
#         zle -N zle-line-finish
#     else
#         for i in {s,r}mkx; do
#             (( ${+terminfo[$i]} )) || debian_missing_features+=($i)
#         done
#         unset i
#     fi
#
#     unfunction bind2maps
#
# fi # [[ -z "$DEBIAN_PREVENT_KEYBOARD_CHANGES" ]] && [[ "$TERM" != 'emacs' ]]
#
# zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
#                                            /usr/local/bin  \
#                                            /usr/sbin       \
#                                            /usr/bin        \
#                                            /sbin           \
#                                            /bin            \
#                                            /usr/X11R6/bin
#
#
#
# (( ${+aliases[run-help]} )) && unalias run-help
# autoload -Uz run-help
#
# # If you don't want compinit called here, place the line
# # skip_global_compinit=1
# # in your $ZDOTDIR/.zshenv
# if grep -q '^ID.*=.*ubuntu' /etc/os-release && [[ -z "$skip_global_compinit" ]]; then
#   autoload -U compinit
#   compinit
# fi

# -------------------------------- -------- -----------------------------------
# [ -f "$ZDOTDIR/zprompt.sh" ] && source "$ZDOTDIR/zprompt.sh"
eval "$(lua ~/.local/share/zsh/plugins/z.lua/z.lua --init zsh)"
eval "$(starship init zsh)"

# fnm
export PATH=/home/cspencer/.local/bin:$PATH
eval "`fnm env`"
