{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];

#Мой СУКА мой РАЗДЕЛ он МОЙ блять все разделы МОИ

  fileSystems."/" = {
      device = "/dev/disk/by-uuid/0f93672e-2b93-4a72-a725-b07d3633a82c";
      fsType = "ext4";
};

  fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/071D-C3AA";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
};

  fileSystems."/home" = {  
      device = "/dev/disk/by-uuid/296ee9eb-594e-48cc-9eea-d6da12561361";
      fsType = "ext4";
};

  fileSystems."/mnt/files_V1" = {
      device = "/dev/vg1/files_V1";
      fsType = "ext4";
};

  fileSystems."/mnt/files_V2" = {
      device = "/dev/vg1/files_V2";
      fsType = "ext4";
};

fileSystems."/mnt/files_V3" = {
      device = "/dev/vg1/files_V3";
      fsType = "ext4";
};
 swapDevices = [ { device = "/dev/vg1/swap"; } ];
 
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
