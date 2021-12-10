{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  home.packages = with pkgs; [
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
