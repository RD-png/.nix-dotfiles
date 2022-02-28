{ inputs, config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  networking.hostName = "nixos-laptop";

  hardware = {
    trackpoint = {
      enable = true;
      emulateWheel = true;
    };
  };
  
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
  };
}
