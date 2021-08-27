{ inputs, config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

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

  # Date and time
  time.timeZone = "Europe/London";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.exportConfiguration = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.displayManager.defaultSession = "none+xmonad";
  services.xserver.windowManager = {
    xmonad = with pkgs; {
      enable = true;
      extraPackages = hpkgs: with hpkgs; [ xmonad xmonad-contrib ];
    };
  };
  services.xserver.xkbOptions = "ctrl:nocaps";

  # nginx server
  networking.hostName = "nixos-laptop";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.nginx = {
    enable = true;
    virtualHosts."ryan-local.com" = {
      root = "/var/htdocs/";
      extraConfig = ''
        autoindex on;
      '';
      locations."~ .php$".extraConfig = ''
        fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
        fastcgi_index index.php;
      '';
    };
  };

  # Php module for nginx server
  services.phpfpm.pools.mypool = {
    user = "nobody";
    settings = {
      pm = "dynamic";
      "listen.owner" = config.services.nginx.user;
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Configure nixpkgs
  nixpkgs.config = {
    allowUnfree = true; # Allow non open source packages
  };

  # Enable experimental flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    autoOptimiseStore = true;
  };
  system.stateVersion = "21.11";

  # System default packages
  environment.systemPackages = with pkgs; [
    home-manager
    vim
    wget
    git
    sqlite
    pcmanfm
    dmenu
    alacritty
    neofetch
    htop
  ];

  # System default fonts
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ source-code-pro ];
  };

  # Default / login shell zsh
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
  };
  users.extraUsers.root = { shell = pkgs.zsh; };

  # Remove generations older than 30 days
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
