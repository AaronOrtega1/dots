#!/bin/bash

# Duración de las fases en segundos
POMODORO=1500 # 25 minutos
BREAK=300     # 5 minutos

# Fase inicial
phase="Pomodoro"
time_left=$POMODORO

while true; do
  if [ $time_left -gt 0 ]; then
    # Mostrar tiempo restante
    echo "$phase: $(($time_left / 60))m $(($time_left % 60))s"
    time_left=$(($time_left - 1))
  else
    # Cambiar entre Pomodoro y Descanso
    if [ "$phase" == "Pomodoro" ]; then
      phase="Break"
      time_left=$BREAK
      notify-send "Pomodoro terminado. Hora de un descanso!"
    else
      phase="Pomodoro"
      time_left=$POMODORO
      notify-send "Descanso terminado. Comienza otro Pomodoro!"
    fi
  fi
  sleep 1
done
