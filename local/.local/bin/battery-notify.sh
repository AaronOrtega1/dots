#!/usr/bin/env bash

# Obtener el dispositivo de batería
BATTERY=$(upower -e | grep BAT)

# Obtener porcentaje y estado actual
PERCENT=$(upower -i "$BATTERY" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
STATE=$(upower -i "$BATTERY" | grep -E "state" | awk '{print $2}')

# Si batería menor a 30% y no está cargando
if [ "$PERCENT" -lt 30 ] && [ "$STATE" = "discharging" ]; then
  notify-send -u critical "󰁽 Battery Low" "Battery at ${PERCENT}%!"
fi
