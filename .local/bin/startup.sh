#!/bin/zsh
# pactl load-module module-alsa-sink device=hw:1,1
copyq & disown
polybar example -r & disown
system76-power charge-thresholds --profile max_lifespan
sudo ifconfig enp35s0 down

