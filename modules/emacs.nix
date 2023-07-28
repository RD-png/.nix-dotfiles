{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-lsp;
  home.packages = with pkgs; [
    ((emacsPackagesFor emacs-lsp).emacsWithPackages (epkgs: [
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
