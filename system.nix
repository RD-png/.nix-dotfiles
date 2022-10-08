{ inputs, config, pkgs, lib, ... }: {

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  time.timeZone = "Europe/London";
  virtualisation.virtualbox.host.enable = true;
  services = {
    xserver = {
      enable = true;
      exportConfiguration = true;
      displayManager = {
        defaultSession = "none+qtile";
        lightdm.enable = true;
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
      # experimentalBackends = true;
      # settings = {
      #   blur = {
      #     method = "kawase";
      #     strength = 75;
      #   };
      # };
    };

    blueman = {
      enable = true;
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

    postgresql = {
      enable = true;
      ensureDatabases = [ "elixir_db" ];
      ensureUsers = [{
        name = "ryan";
        ensurePermissions = { "DATABASE elixir_db" = "ALL PRIVILEGES"; };
      }];
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
      FZF_DEFAULT_OPTS = "--layout=reverse --height 40%";
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
      ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
      BROWSER = "brave";
      TERMINAL = "alacritty";
      EDITOR = "emacs";
    };
    shellAliases = {
      nixRF = "sudo nixos-rebuild switch --flake $HOME#$(uname -n)";
      ls = "exa --long --header --icons --group-directories-first";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      cdp = "cd /var/htdocs/Projects";
      e = "emacsclient -n -c";
      cat = "bat";
      startx = "startx $XINITRC";
    };
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ source-code-pro fantasque-sans-mono font-awesome times-newer-roman fira-code ];
  };

  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      histFile = "$XDG_CONFIG_HOME/zsh/zsh_history";
    };
    fish = {
      enable = true;
    };
  };

  users = {
    users.ryan = {
      isNormalUser = true;
      home = "/home/ryan";
      description = "Ryan User";
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "mysql" ];
      shell = pkgs.fish;
    };
    extraUsers = { root = { shell = pkgs.zsh; }; };
  };

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      trusted-users = [ "root" "ryan" ];
      substituters = [
        "https://nix-community.cachix.org/"
        "https://cache.iog.io"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      auto-optimise-store = true;
    };
  };
  system.stateVersion = "21.11";
}
