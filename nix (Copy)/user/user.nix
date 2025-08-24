  { pkgs, ...}: {
  users.users.diddy = {
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "video" "disk" "network" "input" "networkmanager" "plugdev"]; 
     packages = with pkgs; [
       tree
     ];	
 };      
       time = {
        timeZone = "Asia/Krasnoyarsk";
        hardwareClockInLocalTime = true;
    };
 }
 
