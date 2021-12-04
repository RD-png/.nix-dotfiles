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

  services.xserver = {
    xrandrHeads = [
      {
        output = "DisplayPort-0";
        monitorConfig = ''
          Modeline "1920x1080_144.00"  606.00  1920 1968 2000 2080  1080 1083 1088 1215 +hsync -vsync
          Option "PreferredMode" "1920x1080_144.00"
        '';
      }
    ];
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
