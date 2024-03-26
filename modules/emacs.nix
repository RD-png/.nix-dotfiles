{ pkgs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs29-gtk3;
  home.packages = with pkgs; [
    ((emacsPackagesFor emacs29-gtk3).emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
      vterm
      pdf-tools
      nerd-icons
    ])))
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
