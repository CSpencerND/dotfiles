#!/bin/zsh

ACTIVE_WINDOW=$(xdotool getactivewindow)
KITTY_WINDOWS=$(xdotool search --class alacritty)

if [ -n "${ACTIVE_WINDOW}" ]; then
  if [[ "${KITTY_WINDOWS[@]}" =~ "${ACTIVE_WINDOW}" ]]; then
    xdotool key --delay 0 --clearmodifiers ctrl+shift+v
  else
    xdotool key --delay 0 --clearmodifiers ctrl+v
  fi
fi
