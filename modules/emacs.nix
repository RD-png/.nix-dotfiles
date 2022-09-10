{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsNativeComp;
  home.packages = with pkgs; [
    ((emacsPackagesFor emacsNativeComp).emacsWithPackages (epkgs: [
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
