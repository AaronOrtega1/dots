#!/bin/bash

# Obtener la lista de monitores
MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
INTERNAL_MONITOR=$(echo "$MONITORS" | head -n 1)
EXTERNAL_MONITOR=$(echo "$MONITORS" | tail -n 1)

# Menú de selección con Rofi
# choice=$(echo -e "Solo pantalla integrada\nSolo pantalla externa\nExtender pantallas\n$INTERNAL_MONITOR\n$EXTERNAL_MONITOR" | rofi -dmenu -p "Configuración de Monitor")
choice=$(echo -e "Solo pantalla integrada\nSolo pantalla externa\nExtender pantallas" | rofi -dmenu -p "Configuración de Monitor")

case "$choice" in
"Solo pantalla integrada")
  # Primero deshabilitar todos los monitores
  hyprctl keyword monitor "$EXTERNAL_MONITOR,disabled"
  hyprctl keyword monitor "$INTERNAL_MONITOR,preferred,auto,1.25"
  ;;
"Solo pantalla externa")
  # Primero deshabilitar todos los monitores
  hyprctl keyword monitor "$INTERNAL_MONITOR,disabled"
  hyprctl keyword monitor "$EXTERNAL_MONITOR,preferred,auto,auto"
  ;;
"Extender pantallas")
  # Habilitar ambos monitores
  hyprctl keyword monitor "$INTERNAL_MONITOR,preferred,auto,1.25"
  hyprctl keyword monitor "$EXTERNAL_MONITOR,preferred,auto,auto"
  ;;
esac
