{ config, pkgs, inputs, ... }: {
  programs.tmux = {
    shell = "\${pkgs.fish}/bin/fish";
  };
}
