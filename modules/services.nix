{ pkgs, ... }: {
  programs = {
    man.enable = false;
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
    tmux = {
      shell = "${pkgs.fish}/bin/fish";
    };
  };
}
