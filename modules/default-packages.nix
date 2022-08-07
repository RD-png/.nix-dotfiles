{ config, pkgs, libs, ... }:
let
  pinnedErlang = import
    (builtins.fetchGit {
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "2c9d2d65266c2c3aca1e4c80215de8bee5295b04";
    })
    { };

  erlangR18 = pinnedErlang.erlangR18;
in
{
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
    erlangR18
    # erlang

    go_1_18
    gopls
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
