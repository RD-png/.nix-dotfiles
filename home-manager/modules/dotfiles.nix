{ pkgs, ... }: {
  # General /home dotfiles
  home.file.".npmrc".source = config/dotfiles/npmrc;
  home.file.".nix-channels".source = config/dotfiles/nix-channels;
  home.file.".mbsyncrc".source = config/dotfiles/mbsyncrc;

  # Config files
  xdg.configFile."git".source = config/git;
  xdg.configFile."vim".source = config/vim;
  xdg.configFile."x11".source = config/x11;
  xdg.configFile."alacritty".source = config/alacritty;
}
