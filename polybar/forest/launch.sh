#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/forest"

# Terminate already running bar instances
killall -q polybar

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --config=~/.config/polybar/forest/config.ini --reload main &
    done
else
    polybar --config=~/.config/polybar/forest/config.ini --reload main &
fi
