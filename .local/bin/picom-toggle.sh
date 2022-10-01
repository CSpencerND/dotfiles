#!/usr/bin/env bash

if pgrep -x "picom" > /dev/null
then
	killall picom
else
    picom --config ~/.config/picom/picom.conf -b --experimental-backends &
fi
