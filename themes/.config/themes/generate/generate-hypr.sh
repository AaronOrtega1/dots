#!/bin/bash

source "$HOME/.config/themes/current-theme.sh"

# Remove #
BORDER1="${BORDERS//#}"
BORDER2="${FOCUSED//#}"
INACTIVE="${EMPTY//#}"

cat > "$HOME/.config/hypr/current-theme.conf" <<EOF
\$active_border = 0xff$BORDER1 0xff$BORDER2 45deg
\$inactive_border = 0x66$INACTIVE
EOF
