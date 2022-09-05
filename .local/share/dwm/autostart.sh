#!/bin/bash

function run {
	if ! pgrep $1; then
		$@ &
	fi
}

run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# run "variety"
run "nm-applet"
# run "pamac-tray"
# run "xfce4-power-manager"
run "numlockx on"
run "blueberry-tray"
# run "volumeicon"
run "solaar -w hide -b solaar"
run "redshift-gtk"
# run "cbatticon -x /home/cs/.local/bin/bat-notif.sh"

screens_count=$(xrandr -q | grep " connected" | wc -l)

/home/"$USER"/.local/statusbar/thermals.sh
if [[ $screens_count == 1 ]]; then
    slstatus-sm &   
else
    slstatus &
fi

picom --config ~/.config/picom/picom.conf -b --experimental-backends &

/home/"$USER"/.local/statusbar/weather.py &
# /home/"$USER"/.local/bin/s76-power-default || notify-send "Power Profile" "Failure" &
# /home/"$USER"/.local/statusbar/openweather &
# /home/"$USER"/.local/statusbar/openweather-emoji &
