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
