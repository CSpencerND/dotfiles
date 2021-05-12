alias hp="pactl load-module module-alsa-sink device=hw:1,1"

alias aliases="nano ~/.bash_aliases"
alias source_bash="source ~/.bashrc"

alias kb_off="xinput disable 'AT Translated Set 2 keyboard' && notify-send 'Keyboard' 'Built-in keyboard disabled'"
alias kb_on="xinput enable 'AT Translated Set 2 keyboard' && notify-send 'Keyboard' 'Built-in keyboard enabled'"

alias current_thold="system76-power charge-thresholds"
alias list_thold="system76-power charge-thresholds --list-profiles"
alias set_thold="system76-power charge-thresholds --profile"

alias ethernet_off="sudo ifconfig enp35s0 down"
alias ethernet_on="sudo ifconfig enp35s0 up"

alias startup="Scripts/startup.sh"
