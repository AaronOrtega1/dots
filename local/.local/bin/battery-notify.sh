#!/usr/bin/env bash

# Get battery percentage from upower (works on most Arch laptops)
PERCENT=$(upower -i $(upower -e | grep BAT) | grep -E "percentage" | awk '{print $2}' | tr -d '%')

if [ "$PERCENT" -le 30 ]; then
  notify-send -u critical "󰁽 Battery Low" "Battery at ${PERCENT}%!"
fi
