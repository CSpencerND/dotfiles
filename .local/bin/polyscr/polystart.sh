#!/bin/sh

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do
    sleep 1;
done

polybar example -r & disown
# polybar example -r 2>&1 | tee -a /tmp/polybar1.log & disown
