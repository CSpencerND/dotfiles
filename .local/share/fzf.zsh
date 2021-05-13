# Setup fzf
# ---------
if [[ ! "$PATH" == */home/cspencer/Installed/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/cspencer/Installed/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/cspencer/Installed/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/cspencer/Installed/fzf/shell/key-bindings.zsh"
