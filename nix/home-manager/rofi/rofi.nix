{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "/home/flaemer/nix/home-manager/rofi/theme.rasi";
  };
}
