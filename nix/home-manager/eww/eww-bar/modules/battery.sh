#!/bin/sh

BAT_PATH="/sys/class/power_supply/BAT1"

if [ ! -d "$BAT_PATH" ]; then
    echo "{\"percentage\": \"N/A\", \"status\": \"No battery\", \"icon\": \"\", \"charging\": \"false\"}"
    exit 0
fi

capacity=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo "0")
status=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")

if [ "$status" = "Charging" ]; then
    charging="true"
if [ $capacity -ge 100 ]; then
        icon="󱐋󰁹"
    elif [ $capacity -ge 90 ]; then
        icon="󱐋󰂂"
    elif [ $capacity -ge 80 ]; then
        icon="󱐋󰂁"
    elif [ $capacity -ge 70 ]; then  
        icon="󱐋󰂀"
    elif [ $capacity -ge 60 ]; then
        icon="󱐋󰁿"
    elif [ $capacity -ge 50 ]; then
        icon="󱐋󰁾"
    elif [ $capacity -ge 40 ]; then
        icon="󱐋󰁽"
    elif [ $capacity -ge 30 ]; then
        icon="󱐋󰁼"  
    elif [ $capacity -ge 20 ]; then
        icon="󱐋󰁻"
    elif [ $capacity -ge 10 ]; then
        icon="󱐋󰁺"              
    else
        icon="󱐋󰂎"
    fi
else
    charging="false"
 if [ $capacity -ge 100 ]; then
        icon="󰁹"
    elif [ $capacity -ge 90 ]; then
        icon="󰂂"
    elif [ $capacity -ge 80 ]; then
        icon="󰂁"
    elif [ $capacity -ge 70 ]; then
        icon="󰂀"
    elif [ $capacity -ge 60 ]; then
        icon="󰁿"
    elif [ $capacity -ge 50 ]; then
        icon="󰁾"
    elif [ $capacity -ge 40 ]; then
        icon="󰁽"
    elif [ $capacity -ge 30 ]; then
        icon="󰁼"  
    elif [ $capacity -ge 20 ]; then
        icon="󰁻"
    elif [ $capacity -ge 10 ]; then
        icon="󰁺"                
    else
        icon="󰂎"
    fi
fi

echo "{\"percentage\": \"$capacity%\", \"status\": \"$status\", \"icon\": \"$icon\", \"charging\": \"$charging\"}"
