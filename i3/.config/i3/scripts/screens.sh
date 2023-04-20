#!/bin/sh

xrandr | grep -P "^DP-?1 connected" > /dev/null

if [ $? -eq 0 ]
then
        xrandr --output eDP1 --mode 1920x1080 --pos 960x2160 --rotate normal --output DP1 --mode 3840x2160 --pos 0x0 --rotate normal --output DP2 --mode 1920x1080 --pos 2880x2160 --rotate normal --output DP3 --off --output VIRTUAL1 --off
else
        xrandr --auto
fi
