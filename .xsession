#!/usr/bin/env bash

~/.local/bin/setup_screens &
# ~/.screenlayout/1screens.sh &
# ~/.screenlayout/2screens.sh &

feh --no-fehbg --bg-fill '/home/cs/.local/share/backgrounds/554543.jpg' &
sxhkd &
/home/cs/.local/bin/kbconfig &
/home/cs/.local/bin/kbrate &
leds.sh &

# picom --config ~/.config/picom/picom.conf -b --experimental-backends &
