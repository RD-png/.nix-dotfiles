{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsGcc;
  home.packages = with pkgs; [
    ((emacsPackagesFor emacsGcc).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))
    mu
    binutils
    zstd
    emacs-all-the-icons-fonts
    imagemagick
    rnix-lsp
    gnutls
    isync
    ispell
  ];  
}
