{ config, pkgs, libs, ... }: {
  programs = {
    man.enable = false;
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
