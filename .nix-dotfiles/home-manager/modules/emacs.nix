{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsGcc;
  home.packages = with pkgs; [
    emacsGcc
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
