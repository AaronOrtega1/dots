#!/bin/bash

# Ruta a la carpeta de wallpapers
WALLPAPER_DIR="$HOME/.config/hypr/WallPapers"

# Verifica si se pasa un argumento con la imagen seleccionada
if [ -z "$1" ]; then
  echo "Por favor selecciona un wallpaper"
  exit 1
fi

# Archivo del wallpaper seleccionado
SELECTED_WALLPAPER="$WALLPAPER_DIR/$1"

# Verifica si el archivo existe
if [ ! -f "$SELECTED_WALLPAPER" ]; then
  echo "El wallpaper seleccionado no existe"
  exit 1
fi

# Actualiza el wallpaper en Hyprland y aplica los cambios
swaybg -o '*' -i "$SELECTED_WALLPAPER" -m fill &

# Guarda el wallpaper seleccionado en un archivo para persistencia
echo "exec-once=swaybg -o \* -i $SELECTED_WALLPAPER -m fill" >$HOME/.config/hypr/autoexec.conf
