#! /usr/bin/env bash

# Xephyr -br -ac -reset -screen 1280x720 :1 &

Xephyr +xinerama -br -ac -reset -screen 854x480 -screen 854x480 :1 &

sleep 1s
export DISPLAY=:1
./dwm &
~/.fehbg &
sxhkd &
