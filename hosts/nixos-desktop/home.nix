{ pkgs, ... }:

{

  home.username = "root";
  home.homeDirectory = "/root";

  nixpkgs.config.allowUnfree = true;

  # Imported modules will hand which packages are installed on the system
  imports = [
    ../../modules/home-manager.nix
    ../../modules/nixos-desktop.nix
    ../../modules/emacs.nix
    ../../modules/xmonad.nix
    ../../modules/zsh.nix
  ];

  # General /home dotfiles
  home.file.".npmrc".source = ../../modules/config/dotfiles/.npmrc;
  home.file.".fehbg".source = ../../modules/config/dotfiles/.fehbg;
  home.file.".nix-channels".source = ../../modules/config/dotfiles/.nix-channels;
  home.file.".zprofile".source = ../../modules/config/dotfiles/.zprofile;

  # Config files
  xdg.configFile."git".source = ../../modules/config/git;
  xdg.configFile."shell".source = ../../modules/config/shell;
  xdg.configFile."vim".source = ../../modules/config/vim;
  xdg.configFile."x11".source = ../../modules/config/x11;

}
