{ config, lib, pkgs, ... }:{
 

programs = {
  firefox.enable = true;
  mtr.enable = true;
  niri.enable = true;
  gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
};
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
    };
    extraCompatPackages = [ pkgs.proton-ge-bin ];   
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
  };
}
