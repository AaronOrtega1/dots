# ~/.config/themes/generate/generate-waybar.sh

#!/bin/bash

source "$HOME/.config/themes/current-theme.sh"

cat > "$HOME/.config/waybar/current-theme.css" <<EOF
@define-color background $BACKGROUND;
@define-color text       $TEXT;
@define-color empty      $EMPTY;
@define-color borders    $BORDERS;
@define-color focused    $FOCUSED;
@define-color urgent     $URGENT;
@define-color hover      $HOVER;
EOF
