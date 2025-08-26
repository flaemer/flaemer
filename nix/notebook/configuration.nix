{ config, pkgs, lib, ... }:{

programs = {
  niri.enable = true;
};
  services = {
    printing.enable = true;
    printing.webInterface = true;
};
}
