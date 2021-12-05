{ pkgs, ... }: {
  # General /home dotfiles
  home.file.".npmrc".source = config/dotfiles/npmrc;
  home.file.".mbsyncrc".source = config/dotfiles/mbsyncrc;
}
