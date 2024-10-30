#!/bin/bash

# Terminar Waybar si está en ejecución
pkill waybar

# Esperar un momento para asegurarse de que Waybar se haya cerrado
sleep 1

# Reiniciar Waybar
waybar &
