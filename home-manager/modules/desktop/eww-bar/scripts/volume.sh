#!/bin/sh

per="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F'[: ]+' '/Volume:/ {printf "%d", $2 * 100}')"
mut="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '[MUTED]' && echo "muted" || echo "unmuted")"

icon() {
    if [[ "$mut" == "muted" ]]; then
        echo " " && return
    fi

    if [ "$per" -gt "80" ]; then
        icon=" "
    elif [ "$per" -gt "60" ]; then
        icon=" "
    elif [ "$per" -gt "40" ]; then
        icon=" "
    elif [ "$per" -gt "20" ]; then
        icon=" "
    elif [ "$per" -gt "0" ]; then
        icon=" "
    else
        exit 1
    fi
    
    echo "$icon"
}

percent() {
    echo $per
}

muted() {
    echo $mut
}

[ "$1" = "icon" ] && icon
[ "$1" = "percent" ] && percent
[ "$1" = "muted" ] && muted
exit 0
