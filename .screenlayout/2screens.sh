#!/bin/sh

### 1k
# xrandr --output eDP1 --scale 1x1 --mode 1280x720 --pos 320x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --primary --scale 1x1 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

### 2k (MAIN)
# xrandr --output eDP1 --scale 0.667x0.667 --mode 1920x1080 --pos 320x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --primary --scale 0.75x0.75 --mode 2560x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off

### 4k
xrandr --output eDP1 --scale 0.667x0.667 --mode 1920x1080 --pos 320x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --primary --scale 0.5x0.5 --mode 3840x2160 --pos 0x0 --rotate normal --output VIRTUAL1 --off
