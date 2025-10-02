#!/bin/bash

# Directory where the screenshots will be saved
DIRECTORY="$HOME/Pictures/Screenshots/"

# Nombre de archivo con la fecha y hora actual
# File name with the date and hour
FILE_NAME="screenshots_$(date +%Y-%m-%d_%H-%M-%S).png"
# NOMBRE_ARCHIVO="screenshots_$(date +%Y-%m-%d_%H-%M-%S).avif"

# Complete path of the screenshot
COMPLETE_PATH="$DIRECTORY/$FILE_NAME"

# Create the directory if it doesn't exist
mkdir -p "$DIRECTORY"

# Use slurp to select the area and grim to take the screenshot
grim -g "$(slurp)" "$COMPLETE_PATH"

# Copy the image to the clipboard using wl-copy
cat "$COMPLETE_PATH" | wl-copy

# Message to confirm that the screenshot was saved
notify-send "Screenshot saved in $COMPLETE_PATH and copied to clipboard"
