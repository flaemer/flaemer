{ config, pkgs, lib, ... }:

{
  xdg.configFile."eww/eww.scss".text = ''
$foreground: #ffffff;
$grey: #aaaaaa;
$foreground-alt: #465059;
$background: #0e1419;
$black: #000000;
$red: #ff6565;
$green: #b8cc52;
$yellow: #e6c446;
$blue: #68d4ff;
$magenta: #ffa3aa;
$cyan: #36a3d9;
$white: #ffffff;
$idk: rgba(0, 0, 0, 0);
$rosewater: #f5e0dc;
$flamingo: #f2cdcd;
$pink: #f5c2e7;
$mauve: #cba6f7;
$red: #f38ba8;
$maroon: #eba0ac;
$peach: #fab387;
$yellow: #f9e2af;
$green: #a6e3a1;
$teal: #94e2d5;
$sky: #89dceb;
$sapphire: #74c7ec;
$blue: #89b4fa;
$lavender: #b4befe;
$text: #cdd6f4;
$subtext1: #bac2de;
$subtext0: #a6adc8;
$overlay2: #9399b2;
$overlay1: #7f849c;
$overlay0: #6c7086;
$surface2: #585b70;
$surface1: #45475a;
$surface0: #313244;
$base: rgba(0, 0, 0, 0.3);
$mantle: #181825;
$crust: #11111b;
* {
  padding: 0px;
  margin: 1px;
  all: unset;
  border-radius: 25px;
  background-color: #000
}



window {
  background: $idk;
 border-radius: 8px;
   background-color: transparent;
  padding: 0px;
}
.time {
  background: #000008;
  padding: 6px;
  margin: 0px;
  font-family: 'Nunito', sans-serif;
  font-size: 18px;
  font-weight: 500; /* Regular */
  
}
.player {
  background: #000008;
  margin: 9px;
  padding: 6px;
  font-family: 'Nunito', sans-serif;
  font-size: 18px;
  font-weight: 500; /* Regular */
}
.battery {
  background: #000008;
  font-family: "Symbols Nerd Font Mono";
  font-size: 18px;
}

.ping {
  background: #000008;
    padding: 6px;
  margin: 0px;
  font-family: "Symbols Nerd Font Mono";
  font-size: 18px;
}
.battery {
  background: #000008;
  font-family: "Symbols Nerd Font Mono";
  font-size: 18px;
}

.speaker {
  background: #000008;
  margin: 9px;
  padding: 6px;
  font-family: "Symbols Nerd Font Mono";
  font-size: 18px;
  font-weight: 500; /* Regular */
}
.tray {
  background: #000008;
     background-color: #000008;
  padding: 3px;
  font-family: 'Nunito', sans-serif;
  font-weight: 500; /* Regular */
}
.date {
  background: #000008;
  font-family: 'Nunito', sans-serif;
  padding: 6px;
  margin: 0px;
  font-size: 18px;
  font-weight: 500; /* Regular */
}
.bar {
  font-family: "Noto Sans";
  font-size: 17px;
     background-color: transparent;
  margin: 4 0px;
  
}
.tooltip {
  background-color: $cyan;

  border-radius: 12px;
  font-size: 13px;
  padding: 7px 8px;
}
.icon-module {
  margin: 0 5px;
  & > &__icon {
    margin-right: 5px;
    font-family: "Font Awesome 5 Free Solid";
  }
}
  button {
    margin: 0px 0px;
    color: #ffffff;
  }
  
  
  .occupied {
    color: $cyan;
  }

  .focused {
    color: $red;
  }

  .urgent {
    color: $red; 
      }
    .separator-label {
     background-color: transparent;
     color: transparent;
     }

     .separator{
     background-color: transparent;
     color: transparent; 
    }
  .empty {
    padding-top: 2px;
    background-color: $red;
    font-size: 10px;
//  font-family: "Font Awesome 5 Free Regular"
  }





      '';
}


