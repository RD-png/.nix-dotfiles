{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnome.gnome-settings-daemon
  ];

  programs = {
    dconf = {
      enable = true;
    };
  };

  hardware = {
    pulseaudio = {
      enable = false;
    };
  };
}
