#!/usr/bin/env bash

WALLPAPER_DIR="../WallPapers/"

# find wallpapers (jpg, png, jpeg)
WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort)

# pick one with preview
SELECTED=$(echo "$WALLPAPERS" | tofi --preview --style ~/.config/tofi/catppuccin-mocha --prompt "󰋩 Wallpaper:")

[ -z "$SELECTED" ] && exit 0

# preload and apply with hyprpaper
hyprctl hyprpaper preload "$SELECTED"
hyprctl hyprpaper wallpaper "eDP-1,$SELECTED"

# optional: save as default for next login
sed -i '/^wallpaper = eDP-1/d' ~/.config/hypr/hyprpaper.conf
echo "wallpaper = eDP-1,$SELECTED" >>~/.config/hypr/hyprpaper.conf
