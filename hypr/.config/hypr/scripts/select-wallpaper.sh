#!/bin/bash

# Ruta a la carpeta de wallpapers
WALLPAPER_DIR="$HOME/.config/hypr/WallPapers"

# Abre un selector de archivos (usando Zenity en este caso)
SELECTED_WALLPAPER=$(zenity --file-selection --title="Selecciona un wallpaper" --filename="$WALLPAPER_DIR/" --file-filter="*.png *.jpg")

# Si se selecciona un archivo, cambia el wallpaper
if [ -n "$SELECTED_WALLPAPER" ]; then
  ~/.config/hypr/scripts/set-wallpaper.sh $(basename "$SELECTED_WALLPAPER")
fi
