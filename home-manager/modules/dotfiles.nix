{ pkgs, ... }: {
  # General /home dotfiles
  home.file.".npmrc".source = config/dotfiles/.npmrc;
  home.file.".fehbg".source = config/dotfiles/.fehbg;
  home.file.".nix-channels".source = config/dotfiles/.nix-channels;
  home.file.".zprofile".source = config/shell/profile;

  # Config files
  xdg.configFile."git".source = config/git;
  xdg.configFile."shell".source = config/shell;
  xdg.configFile."vim".source = config/vim;
  xdg.configFile."x11".source = config/x11;
  xdg.configFile."alacritty".source = config/alacritty;
}
