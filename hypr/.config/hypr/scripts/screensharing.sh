#!/bin/bash

# Desactivar otros portales innecesarios
echo "Matando portales innecesarios..."
killall xdg-desktop-portal-gnome 2>/dev/null
killall xdg-desktop-portal-gtk 2>/dev/null
killall xdg-desktop-portal-kde 2>/dev/null

# Esperar un momento para asegurarse de que los procesos se hayan detenido
sleep 1

# Reiniciar los portales de Hyprland
echo "Reiniciando portales de Hyprland..."
killall xdg-desktop-portal-hyprland 2>/dev/null
killall xdg-desktop-portal 2>/dev/null
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &

# Mensaje de éxito
echo "Portales reiniciados correctamente."
