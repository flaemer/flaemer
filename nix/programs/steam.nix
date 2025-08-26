{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    
    # Добавляем аргумент -system-composer
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
