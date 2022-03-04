#!/bin/sh
### 1080
# xrandr --output eDP1 --mode 1920x1080 --scale 1x1 --pos 320x1440 --output HDMI1 --primary --mode 1920x1080 --scale 1.25x1.25 --pos 0x0

### 4k
# xrandr --output eDP1 --mode 1920x1080 --scale 1x1 --pos 960x2160 --output HDMI1 --primary --mode 3840x2160 --scale .75x.75 --pos 0x0

### 2k (MAIN)
xrandr --output eDP1 --mode 1920x1080 --scale 0.85x0.85 --pos 320x1440 --output HDMI1 --primary --mode 2560x1440 --scale 1x1 --pos 0x0

### 2k Alt
# xrandr --output eDP1 --mode 1920x1080 --scale 1x1 --pos 480x2160 --output HDMI1 --primary --mode 2560x1440 --scale 1.25x1.25 --pos 0x0
