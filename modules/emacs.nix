{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsGit;
  home.packages = with pkgs; [
    emacsGit
    mu
    binutils
    zstd
    emacs-all-the-icons-fonts
    rnix-lsp
    gnutls
    isync
    ispell
  ];
}
