#!/bin/sh
xrandr --output Virtual1 --mode 1920x1080 --pos 2160x164 --rotate normal --output Virtual2 --mode 2160x1440 --pos 0x0 --rotate normal
# xrandr --output Virtual-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
# run $HOME/.screenlayout/resolution.sh
nitrogen --restore &
picom --daemon &
sleep 1
