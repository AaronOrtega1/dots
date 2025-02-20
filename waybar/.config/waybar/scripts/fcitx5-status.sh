#!/bin/bash

# Obtiene el método de entrada actual desde Fcitx 5
current_layout=$(fcitx5-remote -n)

# Verifica si no hay ningún método de entrada activo
if [ -z "$current_layout" ]; then
  echo ""
else
  # Verifica si el método de entrada es japonés
  if [[ "$current_layout" == *"mozc"* ]]; then
    echo "あ"
  elif [[ "$current_layout" == *"keyboard-us"* ]]; then
    echo "en"
  else
    echo "$current_layout"
  fi
fi

