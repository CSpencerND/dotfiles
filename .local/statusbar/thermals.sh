#!/usr/bin/env bash

thermal_type=$(cat /sys/class/thermal/thermal_zone0/type)

if [[ "$thermal_type" == "x86_pkg_temp" ]]; then
    thermal_path="/sys/class/thermal/thermal_zone0/temp"
else
    thermal_path="/sys/class/thermal/thermal_zone1/temp"
fi

echo "$thermal_path" > ~/.cache/thermal_path
