{ config, pkgs, lib, ... }:

{
  xdg.configFile = {
    "niri/config.kdl".source = ./config.kdl;
  };
}
