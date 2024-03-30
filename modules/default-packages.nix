{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## General
    lxde.lxsession
    upower
    paper-icon-theme
    rofi
    feh
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
    chatterino2
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
    qbittorrent
    mpv
    mullvad-vpn
    strawberry
    ntfs3g
    exfat
    playerctl

    ## Programming
    texlive.combined.scheme-medium
    haskell.compiler.ghc947
    haskellPackages.haskell-language-server
    stylish-haskell
    cabal-install
    nix-direnv
    direnv
    sqlite
    nixfmt
    nixd
    vim
    git
    gcc
    erlang
    erlang-ls
    elvis-erlang
    gnumake
    rebar3
    niv

    ## Utils
    ripgrep
    pavucontrol
    neofetch
    openssh
    picom
    sshfs
    unzip
    htop
    wget
    tldr
    nitrogen
  ];
}
