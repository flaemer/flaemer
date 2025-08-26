{ config, pkgs, lib, ... }:

{
 xdg.configFile = {
     "eww/modules/ping.sh" = {
      text = ''
 #!/bin/sh

HOST="8.8.8.8"

if  ! ping=$(ping -n -c 1 -W 1 $HOST 2> /dev/null); then
    echo "No"
else
    rtt=$(echo "$ping" | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')
    
    [ -z "$rtt" ] && echo "" && exit
    echo "Yes"
fi
      '';
executable = true;
};

     "eww/modules/speaker.sh" = {
      text = ''
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
      volume="muted"
      icon=""
else 
      volume="$(pamixer --get-volume)"
      if [ "$volume" -gt 66 ]; then
            icon=""
      elif [ "$volume" -gt 33 ]; then
            icon=""
      elif [ "$volume" -gt 0 ]; then 
            icon=""
      else 
            icon=""
      fi
      volume="$volume%"
fi

echo "{\"content\": \"$volume\", \"icon\": \"$icon\"}"


      '';
 executable = true;      
};

     "eww/modules/player.sh" = {
      text = ''
echo "{\"show\": \"no\", \"content\": \"\"}"
playerctl --follow metadata --format '{{artist}} ¿¿¿¿¿ {{ title }}' 2> /dev/null | while read -r line ; do 
   case "$line" in
     ?*\ ¿¿¿¿¿\ ?*) text="$(echo "$line" | sed "s/¿¿¿¿¿/-/")" && should_show="yes";;
     *) text="" && should_show="no" ;;
  esac

  echo "{\"show\": \"$should_show\", \"content\": \"(box (label :text \\\"$text\\\"))\"}"
done 
'';
executable = true; 
}
