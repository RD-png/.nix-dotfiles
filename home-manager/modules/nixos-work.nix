{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    # General
    libreoffice
    thunderbird
    
    # Programming
    postman    
  ];
}
