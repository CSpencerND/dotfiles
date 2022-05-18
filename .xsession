#!/usr/bin/env bash

feh --no-fehbg --bg-fill '/home/cs/.config/variety/Favorites/nice-town.jpeg' &
/home/cs/.local/bin/setup_screens || /home/cs/.screenlayout/2screens.sh
# ~/.screenlayout/1screens.sh &

variety &
sxhkd &
/home/cs/.local/bin/kbconfig &
/home/cs/.local/bin/kbrate &
leds.sh &

# picom --config ~/.config/picom/picom.conf -b --experimental-backends &
