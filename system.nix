{ inputs, config, pkgs, lib, ... }: {

  time.timeZone = "Europe/London";
  services = {
    xserver = {
      enable = true;
      autorun = false;
      exportConfiguration = true;
      displayManager = {
        lightdm.enable = true;
        startx.enable = true;
        defaultSession = "none+qtile";
      };
      windowManager = { qtile = with pkgs; { enable = true; }; };
      layout = "us";
      xkbOptions = "ctrl:nocaps";
      autoRepeatDelay = 250;
      autoRepeatInterval = 25;
    };

    picom = {
      enable = true;
      backend = "glx";
      experimentalBackends = true;
      settings = {
        blur = {
          method = "kawase";
          strength = 75;
        };
        opacity-rule = [ "85:class_g    = 'Alacritty'" ];
      };
    };

    openssh.enable = true;
    fstrim.enable = true;
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    httpd = {
      enable = true;
      user = "ryan";
      enablePHP = true;
      adminAddr = "localhost";
      phpOptions = ''
        display_errors = On
        error_reporting = E_ALL
        opcache.enable = 0
        opcache.revalidate_freq = 0
      '';
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

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    # lorri.enable = true;
  };

  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
    };
  };

  networking = {
    firewall.allowedTCPPorts = [ 80 443 ];
    networkmanager.enable = true;
  };

  security.rtkit.enable = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  nixpkgs.config = { allowUnfree = true; };

  environment = {
    sessionVariables = rec {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_RUNTIME_DIR = "/run/user/$UID";
      PATH = [ "$XDG_BIN_HOME" "$HOME/.config/npm/bin" ];
    };
    variables = {
      INPUTRC = "$XDG_CONFIG_HOME/shell/inputrc";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      HISTFILE = "$XDG_DATA_HOME/history";
      XINITRC = "$XDG_CONFIG_HOME/x11/xinitrc";
      XMONAD_CONFIG_DIR = "$XDG_CONFIG_HOME/xmonad";
      XMONAD_DATA_DIR = "$XDG_CONFIG_HOME/xmonad";
      VIMINIT = "$XDG_CONFIG_HOME/vim/vimrc";      
      BROWSER = "firefox";
      TERMINAL = "alacritty";
      EDITOR = "emacs";
    };
    shellAliases = {
      nixRF = "sudo nixos-rebuild switch --flake .#`uname -n`";
      ls = "exa --long --header --icons --git --group-directories-first -a";
      l = "exa --long --header --icons --git --group-directories-first";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      npmig = "npm install -g --unsafe-perm";
      cdp = "cd /var/htdocs/Projects";
      e = "emacsclient -n -c";
      cat = "bat";
      startx = "startx $XINITRC";
    };
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ source-code-pro fantasque-sans-mono font-awesome ];
  };

  users = {
    users.ryan = {
      isNormalUser = true;
      home = "/home/ryan";
      description = "Ryan User";
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "wwwrun" "mysql" ];
      shell = pkgs.zsh;
    };
    extraUsers = { root = { shell = pkgs.zsh; }; };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  system.stateVersion = "21.11";
}