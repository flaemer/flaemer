{ config, pkgs, lib, ... }:

{
  xdg.configFile."eww/eww.yuck".source = ./eww.yuck;
}
