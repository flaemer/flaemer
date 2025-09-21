{ config, pkgs, lib, ... }:{
  services = {
    printing.enable = true;
    printing.webInterface = true;
  };
}
