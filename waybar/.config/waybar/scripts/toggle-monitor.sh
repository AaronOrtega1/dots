#!/usr/bin/env sh

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Set file variables
scrDir=$(dirname "$(realpath "$0")")
source "$scrDir/globalcontrol.sh"
[ -z "${1}" ] || wlogoutStyle="${1}"
wLayout="${confDir}/wlogout/layout_${wlogoutStyle}"
wlTmplt="${confDir}/wlogout/style_${wlogoutStyle}.css"

if [ ! -f "${wLayout}" ] || [ ! -f "${wlTmplt}" ] ; then
    echo "ERROR: Config ${wlogoutStyle} not found..."
    wlogoutStyle=3  # Cambia a layout_3 por defecto
    wLayout="${confDir}/wlogout/layout_${wlogoutStyle}"
    wlTmplt="${confDir}/wlogout/style_${wlogoutStyle}.css"
fi

# Detect monitor resolution
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select(.focused == true) | .scale' | sed 's/\.//')

# Scale config layout and style
case "${wlogoutStyle}" in
    1)  wlColms=6
        export mgn=$(( y_mon * 38 / hypr_scale ))
        export hvr=$(( y_mon * 33 / hypr_scale )) ;;
    2)  wlColms=2
        export x_mgn=$(( x_mon * 38 / hypr_scale ))
        export y_mgn=$(( y_mon * 28 / hypr_scale ))
        export x_hvr=$(( x_mon * 35 / hypr_scale ))
        export y_hvr=$(( y_mon * 23 / hypr_scale )) ;;
    3)  wlColms=3  # Ajusta según el layout_3
        export mgn=$(( y_mon * 38 / hypr_scale ))
        export hvr=$(( y_mon * 33 / hypr_scale )) ;;
esac

# Scale font size
export fntSize=$(( y_mon * 2 / 100 ))

# Detect wallpaper brightness
[ -f "${cacheDir}/wall.dcol" ] && source "${cacheDir}/wall.dcol"
[ "${dcol_mode}" = "dark" ] && export BtnCol="white" || export BtnCol="black"

# Evaluate hypr border radius
export active_rad=$(( hypr_border * 5 ))
export button_rad=$(( hypr_border * 8 ))

# Evaluate config files
wlStyle=$(envsubst < "$wlTmplt")

# Launch wlogout
wlogout -b "${wlColms}" -c 0 -r 0 -m 0 --layout "${wLayout}" --css <(echo "${wlStyle}") --protocol layer-shell
