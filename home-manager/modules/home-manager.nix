{ config, pkgs, libs, ... }: {
  home.stateVersion = "20.09";
  home.extraOutputsToInstall = [ "man" ];

  programs = {
    home-manager.enable = true;
    man.enable = false;
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
  };
}
