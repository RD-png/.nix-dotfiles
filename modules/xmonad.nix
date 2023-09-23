{ pkgs, ... }: {
  home.packages = with pkgs; [
    xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    cabal-install
  ];
}
