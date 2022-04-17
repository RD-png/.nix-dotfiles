{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    ## General
    gnome-icon-theme
    xfce.tumbler
    xfce.thunar
    xfce.xfconf
    xfce.exo
    alacritty
    discord
    sublime4
    inkscape
    firefox
    cachix
    brave
    libvterm
    flameshot
    pamixer
    libnotify
    dunst
    dmenu
    acpi
    fzf
    xsel
    chromium
    mitscheme
    imagemagick
    poppler
    automake
    zlib
    libpng
    mpv   
    citrix_workspace


    ## Programming
    texlive.combined.scheme-full
    haskell-language-server
    sqlitebrowser
    postgresql
    nix-direnv
    direnv
    sqlite
    nixfmt
    nodejs
    pipenv
    cargo
    vim
    git
    gcc
    ghc
    php
    go_1_18
    gopls
    erlang
    vscode
    erlang-ls
    gnumake
    rebar3
    ocaml
    ocamlPackages.ocaml-lsp
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.intelephense
    
    # Python packages
    python39Packages.python-lsp-server
    python39Packages.setuptools
    python39Packages.virtualenv
    python39Packages.ipython
    python39Packages.pylint
    python39Packages.flake8
    python39Packages.black
    python39Packages.pip
    python39Full
    # Node packages
    nodePackages.npm
    nodePackages.vls
    nodePackages."@vue/cli"
    yarn

    ## Utils
    ripgrep
    pavucontrol
    neofetch
    openssh
    exa    
    picom
    sshfs
    unzip    
    htop
    wget
    tldr
    bat    
    feh
    fd
    sd
  ];
}
