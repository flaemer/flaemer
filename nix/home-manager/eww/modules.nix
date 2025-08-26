{ config, pkgs, lib, ... }:

let
  # Общие настройки для всех скриптов
  scriptConfig = {
    executable = true;
    # Можно добавить общие permissions если нужно
  };
in
{

  # Единый xdg.configFile со всеми скриптами
  xdg.configFile = {
    # Скрипт управления звуком
    "eww/modules/speaker.sh" = scriptConfig // {
      text = ''
        #!/bin/sh

        case $1 in
          "*") command="" ;;
          "up") command="--allow-boost -i 5" ;;
          "down") command="--allow-boost -d 5" ;;
          "toggle") command="-t" ;;
        esac

        [ -n "$command" ] && ${lib.getExe pkgs.pamixer} $command 
        
        mute=$(${lib.getExe pkgs.pamixer} --get-mute)
        if [ "$mute" = "true" ]; then
          volume="muted"
          icon=""
        else 
          volume="$(${lib.getExe pkgs.pamixer} --get-volume)"
          if [ "$volume" -gt 75 ]; then
            icon=""
          elif [ "$volume" -gt 50 ]; then
            icon="󰕾"
          elif [ "$volume" -gt 25 ]; then 
            icon=""            
          elif [ "$volume" -gt 0 ]; then 
            icon=""
          else 
            icon=""
          fi
          volume="$volume%"
        fi

        echo "{\"content\": \"$volume\", \"icon\": \"$icon\"}"
      '';
    };

    # Скрипт управления плеером
    "eww/modules/player.sh" = scriptConfig // {
      text = ''
        #!/bin/sh

        echo "{\"show\": \"no\", \"content\": \"\"}"
        ${lib.getExe pkgs.playerctl} --follow metadata --format '{{artist}} ¿¿¿¿¿ {{ title }}' 2> /dev/null | while read -r line ; do 
          case "$line" in
            ?*\ ¿¿¿¿¿\ ?*) 
              text="$(echo "$line" | ${lib.getExe pkgs.gnused} "s/¿¿¿¿¿/-/")" 
              should_show="yes"
              ;;
            *) 
              text="" 
              should_show="no" 
              ;;
          esac

          echo "{\"show\": \"$should_show\", \"content\": \"(box (label :text \\\"$text\\\"))\"}"
        done
      '';
    };

    # Скрипт проверки ping
    "eww/modules/ping.sh" = scriptConfig // {
      text = ''
        #!/bin/sh

        HOST="8.8.8.8"

        if ! ping=$(${lib.getExe pkgs.inetutils} -n -c 1 -W 1 "$HOST" 2> /dev/null); then
          echo "No"
        else
          rtt=$(echo "$ping" | ${lib.getExe pkgs.gnused} -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')
          
          [ -z "$rtt" ] && echo "" && exit
          echo "Yes"
        fi
      '';
    };

    # Скрипт информации о батарее
    "eww/modules/battery.sh" = scriptConfig // {
      text = ''
        #!/bin/sh

        BAT_PATH="/sys/class/power_supply/BAT1"

        if [ ! -d "$BAT_PATH" ]; then
          echo "{\"percentage\": \"N/A\", \"status\": \"No battery\", \"icon\": \"\", \"charging\": \"false\"}"
          exit 0
        fi

        capacity=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo "0")
        status=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")

        # Определяем иконку и статус
        if [ "$status" = "Charging" ]; then
          charging="true"
          if [ "$capacity" -ge 100 ]; then
            icon="󰂅"    
          elif [ "$capacity" -ge 90 ]; then
            icon="󰂅"
          elif [ "$capacity" -ge 80 ]; then
            icon="󰂊"
          elif [ "$capacity" -ge 70 ]; then
            icon="󰢞"
          elif [ "$capacity" -ge 60 ]; then
            icon="󰂉"
          elif [ "$capacity" -ge 50 ]; then
            icon="󰢝"
          elif [ "$capacity" -ge 40 ]; then
            icon="󰂈"
          elif [ "$capacity" -ge 30 ]; then
            icon="󰂇"  
          elif [ "$capacity" -ge 20 ]; then
            icon="󰂆"
          elif [ "$capacity" -ge 10 ]; then
            icon="󰢜"                
          else
            icon="󰢟"
          fi
        else
          charging="false"
          if [ "$capacity" -ge 100 ]; then
            icon="󰁹"
          elif [ "$capacity" -ge 90 ]; then
            icon="󰂂"
          elif [ "$capacity" -ge 80 ]; then
            icon="󰂁"
          elif [ "$capacity" -ge 70 ]; then
            icon="󰂀"
          elif [ "$capacity" -ge 60 ]; then
            icon="󰁿"
          elif [ "$capacity" -ge 50 ]; then
            icon="󰁾"
          elif [ "$capacity" -ge 40 ]; then
            icon="󰁽"
          elif [ "$capacity" -ge 30 ]; then
            icon="󰁼"  
          elif [ "$capacity" -ge 20 ]; then
            icon="󰁻"
          elif [ "$capacity" -ge 10 ]; then
            icon="󰁺"                
          else
            icon="󰂎"
          fi
        fi

        echo "{\"percentage\": \"$capacity%\", \"status\": \"$status\", \"icon\": \"$icon\", \"charging\": \"$charging\"}"
      '';
    };
  };
}
