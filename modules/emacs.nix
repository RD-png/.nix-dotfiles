{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsUnstable;
  home.packages = with pkgs; [
    ((emacsPackagesFor emacsUnstable).emacsWithPackages (epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
    ]))
    mu
    binutils
    zstd
    emacs-all-the-icons-fonts
    gnutls
    isync
    ispell
  ];
}
