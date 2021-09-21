{ inputs, config, pkgs, lib, ... }: {
  # Specific settings for this user profile
  imports = [ ./hardware-configuration.nix ];

  # Hostname
  networking.hostName = "nixos-work";

  # Grub boot loader
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
  };

  # System default packages
  # environment.systemPackages = with pkgs; [ ];

  # System default fonts
  # fonts = {
  #   fontDir.enable = true;
  #   fonts = with pkgs; [ ];
  # };
}
