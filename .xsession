#!/usr/bin/env bash

/home/cs/.local/bin/setup_screens || /home/cs/.screenlayout/2screens.sh
# ~/.screenlayout/1screens.sh &

feh --no-fehbg --bg-fill '/home/cs/.local/share/backgrounds/554543.jpg' &
sxhkd &
/home/cs/.local/bin/kbconfig &
/home/cs/.local/bin/kbrate &
leds.sh &

# picom --config ~/.config/picom/picom.conf -b --experimental-backends &
