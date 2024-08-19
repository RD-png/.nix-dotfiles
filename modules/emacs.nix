{ pkgs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-gtk;
  home.packages = with pkgs; [
    ((emacsPackagesFor emacs-gtk).emacsWithPackages (epkgs: with epkgs.melpaPackages; [
      vterm
      pdf-tools
      nerd-icons
    ]))
    mu
    binutils
    zstd
    emacs-all-the-icons-fonts
    gnutls
    isync
    ispell
    emacs-lsp-booster
  ];
}
