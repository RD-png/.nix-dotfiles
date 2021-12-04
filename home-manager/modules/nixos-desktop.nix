{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    # General
    discord
    spotify
    inkscape
    
    # Programming
    mitscheme    
    scheme48
    racket
  ];
}
