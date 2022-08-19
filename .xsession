#!/usr/bin/env bash

mpv --no-video ~/Music/ps2_start_up.mp3 &
# feh --no-fehbg --bg-fill '/home/cs/.config/variety/Favorites/nice-town.jpeg' &
/home/cs/.local/bin/setup_screens || /home/cs/.screenlayout/2screens.sh
[[ $(cat /sys/class/power_supply/AC/online) == 1 ]] && xbacklight -set 100 &
# ~/.screenlayout/1screens.sh &

variety &
sxhkd &

# /home/cs/.local/bin/kbconfig || /home/cs/.local/bin/kbrate &
xset r rate 250 60 &
