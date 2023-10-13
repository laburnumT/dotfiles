#!/bin/sh

if xrandr | grep -P "^DP-?1 connected" >/dev/null; then
        xrandr --output eDP1 --mode 1920x1080 --pos 960x2160 --rotate normal --output DP1 --mode 3840x2160 --pos 0x0 --rotate normal --output DP2 --mode 1920x1080 --pos 2880x2160 --rotate normal --output DP3 --off --output VIRTUAL1 --off
        i3-msg 'workspace 1; move workspace to output DP1'
        i3-msg 'workspace 2; move workspace to output eDP1'
        i3-msg 'workspace 3; move workspace to output DP2'
else
        xrandr --auto
fi
