{ config, pkgs, lib, ... }:

let
  makeExecutable = path: {
    source = path;
    executable = true;
  };
in
{
  xdg.configFile = {
    "eww/eww.scss".source = ./eww-bar/eww.scss;
    "eww/eww.yuck".source = ./eww-bar/eww.yuck;

    #modules btw
    "eww/modules/battery.sh" = makeExecutable ./eww-bar/modules/battery.sh;
    "eww/modules/player.sh" = makeExecutable ./eww-bar/modules/player.sh;
    "eww/modules/speaker.sh" = makeExecutable ./eww-bar/modules/speaker.sh;
    "eww/modules/ping.sh" = makeExecutable ./eww-bar/modules/ping.sh;
  };
}
