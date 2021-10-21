{ inputs, config, pkgs, lib, ... }: {

  # Date and time
  time.timeZone = "Europe/London";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = false;
    exportConfiguration = true;
    displayManager = {
      startx.enable = true;
      defaultSession = "none+xmonad";
    };
    windowManager = {
      xmonad = with pkgs; {
        enable = true;
        extraPackages = hpkgs: with hpkgs; [ xmonad xmonad-contrib ];
      };
    };
    layout = "gb";
    xkbOptions = "ctrl:nocaps";
  };
  services.lorri.enable = true;


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
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  # sound.enable = true;
  # hardware.pulseaudio = {
  #   enable = true;
  #   support32Bit = true;
  # };
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
    dmenu
    alacritty
    neofetch
    htop
    xfce.thunar
    xfce.tumbler
    xfce.xfconf
    xfce.exo
    gnome-icon-theme
  ];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_STATE_HOME = "\${HOME}/.local/state";

    PATH = [
      "\${XDG_BIN_HOME}"
      "\${HOME}/.config/npm/bin"
    ];
  };

  environment.variables = {
    INPUTRC = "\${XDG_CONFIG_HOME}/shell/inputrc";
    CARGO_HOME = "\${XDG_DATA_HOME}/cargo";
    HISTFILE = "\${XDG_DATA_HOME}/history";
    XINITRC = "\${XDG_CONFIG_HOME}/x11/xinitrc";
    XMONAD_CONFIG_DIR = "\${XDG_CONFIG_HOME}/xmonad";
    XMONAD_DATA_DIR = "\${XDG_CONFIG_HOME}/xmonad";
    VIMINIT = "\${XDG_CONFIG_HOME}/vim/vimrc";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    EDITOR = "emacs";
  };

  environment.interactiveShellInit = ''
    alias homeRF="home-manager switch --flake '"$HOME"/.nix-dotfiles/home-manager#`uname -n`'"
    alias nixRF="sudo nixos-rebuild switch --flake '"$HOME"/.nix-dotfiles/nixos#`uname -n`'"
    alias grep='grep --color=auto'
    alias	diff="diff --color=auto"
    alias npmig='npm install -g --unsafe-perm'
    alias cdp="cd /var/htdocs/Projects"
    alias e="emacsclient -n -c"
    alias	cat="bat"
    [ -f "$XINITRC" ] && alias startx="startx $XINITRC"
  '';

  # Default system fonts
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      source-code-pro
      fantasque-sans-mono
    ];
  };

  users.users.ryan = {
    isNormalUser = true;
    home = "/home/ryan";
    description = "Ryan User";
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };
  # users.extraUsers.ryan = { shell = pkgs.fish; };

  # Remove generations older than 30 days
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
