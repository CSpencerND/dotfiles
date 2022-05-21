#!/usr/bin/env bash

hkid=$(ps -ef | grep hotkeys.py | grep python | awk '{print $2}')
[ -z "$hkid" ] && hotkeys.py || kill -9 $hkid
