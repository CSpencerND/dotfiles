#! /usr/bin/env bash

Xephyr -br -ac -reset -screen 1920x1080 :1 &
sleep 1s
export DISPLAY=:1
./dwm &
~/.fehbg &
sxhkd &
