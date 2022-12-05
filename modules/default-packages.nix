{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    ## General
    lxde.lxsession
    upower
    paper-icon-theme
    rofi
    feh
    qtile
    pnmixer
    lxqt.lxqt-powermanagement
    dunst
    xfce.tumbler
    xfce.thunar
    xfce.xfconf
    xfce.exo
    alacritty
    discord
    inkscape
    cachix
    brave
    tmux
    libvterm
    flameshot
    pamixer
    libnotify
    dmenu
    acpi
    fzf
    xsel
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
    texlive.combined.scheme-medium
    ghc
    stylish-haskell
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
    erlang-ls
    elvis-erlang
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
    picom-jonaburg
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
