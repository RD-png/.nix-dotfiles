{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    ## General
    pa_applet
    adw-gtk3
    xfce.xfce4-power-manager
    lxde.lxsession
    dunst
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
    dmenu
    acpi
    fzf
    xsel
    chromium
    mitscheme
    spotify
    imagemagick
    poppler
    automake
    zlib
    libpng
    vlc
    bluez
    autorandr

    ## Programming
    texlive.combined.scheme-full
    haskell-language-server
    cabal-install
    nix-direnv
    direnv
    sqlite
    nixfmt
    rnix-lsp
    vim
    git
    gcc
    ghc
    erlang
    go_1_18
    gopls
    erlang-ls
    gnumake
    rebar3
    ocaml
    ocamlPackages.ocaml-lsp
    niv

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
    nitrogen
    fd
    sd
  ];
}
