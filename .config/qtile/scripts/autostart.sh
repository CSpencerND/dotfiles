#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Set your native resolution IF it does not exist in xrandr
#More info in the script
#run $HOME/.config/qtile/scripts/set-screen-resolution-in-virtualbox.sh

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

# xrandr --output eDP1 --mode 1920x1080 --rate 60
# xrandr --output HDMI1 --mode 1920x1080 --rate 60
/home/cs/.config/qtile/scripts/screens.sh

#change your keyboard if you need it
#setxkbmap -layout be

#autostart ArcoLinux Welcome App
# run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop &

#Some ways to set your wallpaper besides variety or nitrogen
# feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &
# nitrogen --restore &
#start the conky to learn the shortcuts
# (conky -c $HOME/.config/qtile/scripts/system-overview) &

# picom --config $HOME/.config/qtile/scripts/picom.conf -b --experimental-backends &
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

run variety &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueberry-tray &
run solaar -w hide -b solaar &
run volumeicon &
run redshift-gtk &
# run cbatticon &

# run dunst &
# run discord &
# run dropbox &
pactl load-module module-alsa-sink device=hw:1,1 &
/home/cs/.local/bin/kbconfig &
# /home/cs/.local/bin/kbrate &
# /home/cs/.local/statusbar/openweather-emoji &

# /home/cs/.local/bin/s76-power-default || notify-send "Power Profile" "Failure"
