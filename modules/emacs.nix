{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsGit;
  home.packages = with pkgs; [
    ((emacsPackagesFor emacsGit).emacsWithPackages (epkgs: [
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
