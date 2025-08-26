  { pkgs, ...}: {
  users.users.flaemer = {
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "video" "disk" "network" "input" "networkmanager" "plugdev"]; 
     packages = with pkgs; [
       tree
     ];	
 };    
   users.users.flymer = {
	isNormalUser = true;
	extraGroups = [ "wheel" "audio" "video" "network" "input" "networkmanager" "plugdev" "disk"];
	packages = with pkgs; [
	tree
	];
};    
       time = {
        timeZone = "Asia/Krasnoyarsk";
        hardwareClockInLocalTime = true;
    };
 }
 
