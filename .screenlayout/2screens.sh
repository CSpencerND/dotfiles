#!/bin/sh

### low dpi that linux can handle
xrandr --output eDP1 --mode 1280x720 --pos 300x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
# xrandr --output eDP1 --mode 1600x900 --pos 300x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

### 1080
# xrandr --output eDP1 --mode 1920x1080 --scale 1x1 --pos 320x1440 --output HDMI1 --primary --mode 1920x1080 --scale 1.25x1.25 --pos 0x0

### 4k
# xrandr --output eDP1 --mode 1920x1080 --scale 1x1 --pos 960x2160 --output HDMI1 --primary --mode 3840x2160 --scale .75x.75 --pos 0x0

### 2k (MAIN)
# xrandr --output eDP1 --mode 1920x1080 --scale 0.825x0.825 --pos 320x1440 --output HDMI1 --primary --mode 2560x1440 --scale 1x1 --pos 0x0

### 2k Alt
# xrandr --output eDP1 --mode 1920x1080 --scale 1x1 --pos 480x2160 --output HDMI1 --primary --mode 2560x1440 --scale 1.25x1.25 --pos 0x0
