{ config, lib, pkgs, ... }:{
 

programs = {
  chromium.enable = true;
  mtr.enable = true;
  niri.enable = true;
  gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
};
  steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
    };   
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
};
}

