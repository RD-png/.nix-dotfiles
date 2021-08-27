{ inputs, config, pkgs, lib, ... }: {
  # Specific settings for this user profile
  imports = [ ./hardware-configuration.nix ];

  # Hostname
  networking.hostName = "nixos-desktop";

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

  # Enable amd cpu
  hardware.cpu.amd.updateMicrocode = true;

  # Default system packages
  # environment.systemPackages = with pkgs; [ ];

  # Default system fonts
  # fonts = {
  #   fontDir.enable = true;
  #   fonts = with pkgs; [ source-code-pro ];
  # };
}
