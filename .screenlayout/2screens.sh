#!/bin/sh

xrandr --output eDP-1 --mode 1600x900 --pos 480x1440 --rotate normal \
       --output DP-1 --primary --mode 2560x1440 --rate 75 --pos 1080x0 --rotate normal \
       --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off
