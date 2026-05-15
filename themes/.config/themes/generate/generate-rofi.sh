#!/bin/bash

source "$HOME/.config/themes/current-theme.sh"

cat > "$HOME/.config/rofi/current-theme.rasi" <<EOF
* {
    bg: $BACKGROUND;
    bg-alt: $BACKGROUND_ALT;

    fg: $TEXT;

    urgent: $URGENT;

    border: $BORDERS;
    selected: $FOCUSED;

    comment: $COMMENT;

    background-color: transparent;
    text-color: @fg;
}
EOF
