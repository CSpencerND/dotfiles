#!/bin/sh

### 1600x900
xrandr --output eDP-1 --primary --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off

### 1080 proper
# xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off
# xrandr --newmode "1920x1080_120.00" 369.50 1920 2080 2288 2656 1080 1083 1088 1160 -hsync +vsync
# xrandr --addmode eDP-1 1920x1080_120.00
# xrandr --output eDP-1 --mode 1920x1080_120.00

### 1080 scaled
# xrandr --newmode "1920x1080_120.00" 369.50 1920 2080 2288 2656 1080 1083 1088 1160 -hsync +vsync && \
# xrandr --addmode eDP1 1920x1080_120.00 && \
# xrandr --output eDP1 --scale 0.667x0.667 --mode 1920x1080_120.00 --pos 0x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --off --output VIRTUAL1 --off || \
# xrandr --output eDP1 --scale 0.667x0.667 --mode 1920x1080 --pos 0x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --off --output VIRTUAL1 --off

# xrandr --output eDP1 --scale 1x1 --mode 1920x1080 --pos 0x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --off --output VIRTUAL1 --off

### 720 proper
# xrandr --newmode "1280x720_120.00" 162.00 1280 1376 1512 1744 720 723 728 775 -hsync +vsync
# xrandr --addmode eDP-1 1280x720_120.00
# xrandr --output eDP-1 --scale 1x1 --mode 1280x720_120.00 --pos 0x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --off --output VIRTUAL1 --off || \
# xrandr --output eDP-1 --scale 1x1 --mode 1280x720 --pos 0x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output DP4 --off --output HDMI1 --off --output VIRTUAL1 --off

