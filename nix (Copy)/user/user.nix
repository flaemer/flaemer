  { pkgs, ...}: {
  users.users.Diddy = {
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
 
