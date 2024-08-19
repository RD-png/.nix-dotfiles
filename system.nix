{ pkgs, lib, ... }: {
  time.timeZone = "Europe/London";
  services = {
    xserver = {
      enable = true;
      exportConfiguration = true;
      displayManager = {
        defaultSession = "qtile";
        lightdm.enable = true;
      };
      windowManager = {
        qtile = {
          enable = true;
        };
      };
      xkb = {
        layout = "us";
        options = "ctrl:nocaps";
      };
      autoRepeatDelay = 250;
      autoRepeatInterval = 25;
    };

    picom = {
      enable = true;
      backend = "glx";
    };

    blueman = {
      enable = true;
    };

    upower = {
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

    mullvad-vpn = {
      enable = true;
    };

     gvfs = {
      enable = true;
    };

    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };

    devmon = {
      enable = true;
    };
  };

  networking = {
    firewall.allowedTCPPorts = [ 80 443 2181 ];
    networkmanager.enable = true;
  };

  security.rtkit.enable = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  environment = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_RUNTIME_DIR = "/run/user/$UID";
      FZF_DEFAULT_OPTS = "--layout=reverse --height 40%";
      PATH = [ "$XDG_BIN_HOME" ];
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
      ls = "ls --group-directories-first --color -l";
      lsd = "ls -d */";
      lsa = "ls -a";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      cdd = "fzf-cd-widget -e --tiebreak=length";
      cdf = "fzf-file-widget -e";
      nixrf = "sudo nixos-rebuild switch --flake $HOME#$(uname -n)";
      grep = "rg";
      diff = "diff --color=auto";
      e = "emacsclient -n -c";
      startx = "startx $XINITRC";
    };
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      source-code-pro
      fantasque-sans-mono
      font-awesome
      times-newer-roman
      fira-code
    ];
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
    nm-applet = {
      enable = true;
    };
    light = {
      enable = true;
    };
  };

  users = {
    users.ryan = {
      isNormalUser = true;
      home = "/home/ryan";
      description = "Ryan User";
      extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
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
