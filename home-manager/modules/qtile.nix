{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [ ];
  xdg.configFile."qtile".source = config/qtile;
}
