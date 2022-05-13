#!/usr/bin/env bash

notify-send "$(acpi | sed 's/Battery 0: //' | head -1)"
