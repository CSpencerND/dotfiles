#!/usr/bin/env bash

if pgrep -x "sxhkd" > /dev/null
then
    pkill -USR1 -x sxhkd
    notify-send "sxhkd restarted successfully"
else
    notify-send "sxhkd is not currently running"
fi
