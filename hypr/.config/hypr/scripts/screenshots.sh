#!/bin/bash

# Directorio donde se guardarán las capturas
DIRECTORIO="$HOME/Pictures/Screenshots/"

# Nombre de archivo con la fecha y hora actual
NOMBRE_ARCHIVO="screenshots_$(date +%Y-%m-%d_%H-%M-%S).png"

# Ruta completa de la captura
RUTA_COMPLETA="$DIRECTORIO/$NOMBRE_ARCHIVO"

# Crear el directorio si no existe
mkdir -p "$DIRECTORIO"

# Usar slurp para seleccionar el área y grim para tomar la captura
grim -g "$(slurp)" "$RUTA_COMPLETA"

# Copiar la imagen al portapapeles utilizando wl-copy
cat "$RUTA_COMPLETA" | wl-copy

# Mensaje opcional para confirmar que se guardó la captura
echo "Captura de pantalla guardada en $RUTA_COMPLETA y copiada al portapapeles."
