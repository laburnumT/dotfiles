#!/bin/sh

xrandr --output eDP1 --primary --mode 1920x1080 --pos 1030x2160 --rotate normal --output DP1 --mode 3840x2160 --pos 0x0 --rotate normal --output DP2 --off --output DP3 --off --output VIRTUAL1 --off
i3-msg 'workspace 1; move workspace to output DP1'
