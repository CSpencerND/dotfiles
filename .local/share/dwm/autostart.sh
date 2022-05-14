#!/bin/bash

function run {
	if ! pgrep $1; then
		$@ &
	fi
}

# ~/.local/bin/setup_screens &
# feh --no-fehbg --bg-fill '/home/cs/.local/share/backgrounds/554543.jpg' &
# sxhkd &
# /home/cs/.local/bin/kbconfig &
# /home/cs/.local/bin/kbrate &
# leds.sh &

run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
/usr/lib/xfce4/notifyd/xfce4-notifyd &

run "variety"
run "nm-applet"
run "pamac-tray"
# run "xfce4-power-manager"
run "numlockx on"
run "blueberry-tray"
# run "volumeicon"
run "solaar -w hide -b solaar"
run "redshift-gtk"
# run "cbatticon -x /home/cs/.local/bin/bat-notif.sh"

screens_count=$(xrandr -q | grep " connected" | wc -l)
if [[ $screens_count == 1 ]]; then
    slstatus-sm &   
else
    slstatus &
fi

# skippy-xd --start-daemon &

picom --config ~/.config/picom/picom.conf -b --experimental-backends &
# picom -b &

/home/cs/.local/statusbar/weather.py &
# /home/cs/.local/bin/s76-power-default || notify-send "Power Profile" "Failure" &
# /home/cs/.local/statusbar/openweather &
# /home/cs/.local/statusbar/openweather-emoji &
