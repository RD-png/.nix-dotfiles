{ inputs, config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./home.nix ];

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
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
  };
}
