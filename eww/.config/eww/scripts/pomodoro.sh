#!/bin/bash

# Configuration
POMODORO_DIR="$HOME/.config/eww"
TIME_FILE="/tmp/pomodoro_time"
MODE_FILE="/tmp/pomodoro_mode"
SESSIONS_FILE="/tmp/pomodoro_sessions"
STATE_FILE="/tmp/pomodoro_state"

# Catppuccin Mocha colors
COLOR_FOCUS="#f5c2e7"
COLOR_SHORT_BREAK="#a6e3a1"
COLOR_LONG_BREAK="#89dceb"
COLOR_IDLE="#bac2de"

# Default values
FOCUS_TIME=3000 # 50 minutes in seconds
SHORT_BREAK=600 # 10 minutes in seconds
LONG_BREAK=1200 # 20 minutes in seconds
MAX_SESSIONS=4

initialize_files() {
  echo "50:00" >"$TIME_FILE"
  echo "Idle" >"$MODE_FILE"
  echo "Sessions: 0/$MAX_SESSIONS" >"$SESSIONS_FILE"
  echo "IDLE" >"$STATE_FILE"
}

format_time() {
  local total_seconds=$1
  local minutes=$((total_seconds / 60))
  local seconds=$((total_seconds % 60))
  printf "%02d:%02d" "$minutes" "$seconds"
}

update_display() {
  local time_left=$1
  local mode=$2
  local sessions=$3

  format_time "$time_left" >"$TIME_FILE"
  echo "$mode" >"$MODE_FILE"
  echo "Sessions: $sessions/$MAX_SESSIONS" >"$SESSIONS_FILE"
}

start_timer() {
  local state=$(cat "$STATE_FILE")

  if [[ "$state" == "RUNNING" ]]; then
    return
  fi

  local mode=$(cat "$MODE_FILE")
  local sessions=$(cat "$SESSIONS_FILE" | cut -d' ' -f2 | cut -d'/' -f1)

  case "$mode" in
  "Focus Time")
    run_timer "$FOCUS_TIME" "Focus Time" "$sessions" "SHORT_BREAK"
    ;;
  "Short Break")
    run_timer "$SHORT_BREAK" "Short Break" "$sessions" "FOCUS"
    ;;
  "Long Break")
    run_timer "$LONG_BREAK" "Long Break" "$sessions" "FOCUS"
    ;;
  "Idle")
    sessions=0
    run_timer "$FOCUS_TIME" "Focus Time" "$sessions" "SHORT_BREAK"
    ;;
  esac
}

run_timer() {
  local duration=$1
  local mode=$2
  local sessions=$3
  local next_mode=$4

  echo "RUNNING" >"$STATE_FILE"
  update_display "$duration" "$mode" "$sessions"

  while [[ $duration -gt 0 ]] && [[ $(cat "$STATE_FILE") == "RUNNING" ]]; do
    sleep 1
    duration=$((duration - 1))
    update_display "$duration" "$mode" "$sessions"
  done

  if [[ $(cat "$STATE_FILE") == "RUNNING" ]]; then
    # Timer completed naturally
    case "$next_mode" in
    "SHORT_BREAK")
      sessions=$((sessions + 1))
      if [[ $sessions -ge $MAX_SESSIONS ]]; then
        sessions=0
        next_mode="LONG_BREAK"
        mode="Long Break"
        duration=$LONG_BREAK
      else
        mode="Short Break"
        duration=$SHORT_BREAK
      fi
      ;;
    "LONG_BREAK")
      mode="Focus Time"
      duration=$FOCUS_TIME
      next_mode="SHORT_BREAK"
      ;;
    "FOCUS")
      mode="Focus Time"
      duration=$FOCUS_TIME
      next_mode="SHORT_BREAK"
      ;;
    esac

    # Send notification
    notify-send "Pomodoro Timer" "$mode session completed!" -u normal

    # Update sessions file
    echo "Sessions: $sessions/$MAX_SESSIONS" >"$SESSIONS_FILE"

    # Start next timer if auto-continue is desired
    # run_timer "$duration" "$mode" "$sessions" "$next_mode"
  fi
}

pause_timer() {
  echo "PAUSED" >"$STATE_FILE"
}

stop_timer() {
  echo "IDLE" >"$STATE_FILE"
  echo "50:00" >"$TIME_FILE"
  echo "Idle" >"$MODE_FILE"
  echo "Sessions: 0/$MAX_SESSIONS" >"$SESSIONS_FILE"
}

# Initialize files if they don't exist
if [[ ! -f "$TIME_FILE" ]]; then
  initialize_files
fi

# Handle commands
case "$1" in
"start")
  start_timer
  ;;
"pause")
  pause_timer
  ;;
"stop")
  stop_timer
  ;;
"toggle")
  state=$(cat "$STATE_FILE")
  if [[ "$state" == "RUNNING" ]]; then
    pause_timer
  else
    start_timer
  fi
  ;;
*)
  echo "Usage: $0 {start|pause|stop|toggle}"
  exit 1
  ;;
esac
