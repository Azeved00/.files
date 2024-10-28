#!/bin/sh

wired="$(nmcli -t -f TYPE con show --active | grep -q "ethernet" && echo "true" || echo "false")"

icon() {
    if [[ "$wired" == "true" ]]; then
        echo "󰈁" && exit
    fi

    per="$(nmcli -f IN-USE,SSID,SIGNAL dev wifi | awk '/^\*/ {print $3}')"


    if [ "$per" -gt "80" ]; then
        icon="󰤨"
    elif [ "$per" -gt "60" ]; then
        icon="󰤥"
    elif [ "$per" -gt "40" ]; then
        icon="󰤢"
    elif [ "$per" -gt "20" ]; then
        icon="󰤟"
    elif [ "$per" -gt "0" ]; then
        icon="󰤮"
    else
        echo  && exit
    fi
    echo "$icon"
}

strength() {
    if [[ "$wired" == "true" ]]; then
        echo "Wired Connection" && exit
    fi
    
    echo "$per%"
}


[ "$1" = "icon" ] && icon && exit
[ "$1" = "strength" ] && strength && exit
exit
