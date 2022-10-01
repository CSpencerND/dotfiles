#!/bin/bash

mpv --no-video ~/Music/ps2_start_up.mp3 &
# feh --no-fehbg --bg-fill '/home/cs/.config/variety/Favorites/nice-town.jpeg' &
/home/cs/.local/bin/setup_screens || /home/cs/.screenlayout/2screens.sh
[[ $(cat /sys/class/power_supply/AC/online) == 1 ]] && xbacklight -set 100 &
# ~/.screenlayout/1screens.sh &

variety &
sxhkd &

# /home/cs/.local/bin/kbconfig || /home/cs/.local/bin/kbrate &
xset r rate 250 60 &

function run {
	if ! pgrep $1; then
		$@ &
	fi
}

# run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "/usr/libexec/polkit-gnome-authentication-agent-1"
# run "/usr/lib64/xfce4/notifyd/xfce4-notifyd"
run "dunst"

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
/home/"$USER"/.local/statusbar/headset-perc &
# /home/"$USER"/.local/bin/s76-power-default || notify-send "Power Profile" "Failure" &
# /home/"$USER"/.local/statusbar/openweather &
# /home/"$USER"/.local/statusbar/openweather-emoji &
