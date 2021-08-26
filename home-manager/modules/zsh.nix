{ config, options, pkgs, ... }: {
  home.packages = with pkgs; [ exa fzf tldr fd bat ];

  xdg.configFile."zsh".source = config/zsh;
}
