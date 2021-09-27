{ inputs, config, pkgs, lib, ... }: {

  # Date and time
  time.timeZone = "Europe/London";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.exportConfiguration = true;
  services.lorri.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.displayManager.defaultSession = "none+xmonad";
  services.xserver.windowManager = {
    xmonad = with pkgs; {
      enable = true;
      extraPackages = hpkgs: with hpkgs; [ xmonad xmonad-contrib ];
    };
  };
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.layout = "gb";

  # apache server
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.httpd = {
    enable = true;
    enablePHP = true;
    adminAddr = "localhost";

    extraModules = [ "http2" ];

    virtualHosts = {
      localhost = {
        enableUserDir = true;
        documentRoot = "/var/htdocs";
        enableSSL = false;
        extraConfig = ''
          <Directory "/var/htdocs">
          Require all granted
          </Directory>

          <IfModule mod_dir.c>
          DirectoryIndex index.html
          </IfModule>
        '';
      };
    };
  };
  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };
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

  # Default system packages
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

  # Default system fonts
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
