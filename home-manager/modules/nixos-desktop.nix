{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    # General
    discord
    spotify
    
    # Programming
    mitscheme    
    scheme48
  ];
}
