{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    cabal-install
    feh
    font-awesome
  ];

  xdg.configFile."xmonad".source = config.lib.file.mkOutOfStoreSymlink
    (config.home.homeDirectory
      + ".nix-dotfiles/home-manager/modules/config/xmonad");
}
