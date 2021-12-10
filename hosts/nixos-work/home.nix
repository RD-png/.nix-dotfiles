{ config, pkgs, libs, ... }: {
  # Packages for this host
  home-manager.users.ryan.home.packages = with pkgs; [
    # General
    libreoffice
    thunderbird

    # Programming
    postman
  ];
}
