#!/bin/sh

case $1 in
      "*") command="" ;;
      "up") command="--allow-boost -i 5" ;;
      "down") command="--allow-boost -d 5" ;;
      "toogle") command="-t" ;;
esac

[ -n "$command" ] && pamixer $command 
mute=$(pamixer --get-mute)
if [ "$mute" = "true" ]; then
      volume=""
      icon=""
else 
      volume="$(pamixer --get-volume)"
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


