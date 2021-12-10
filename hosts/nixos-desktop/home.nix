{ config, pkgs, ... }: {
  # Packages for this host
  home-manager.users.ryan.home.packages = with pkgs; [
    # General
    discord
    spotify
    inkscape

    # Programming
    mitscheme
    scheme48
    racket

    cowsay
  ];
}
