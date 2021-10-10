{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsPgtkGcc;
  home.packages = with pkgs; [
    ((emacsPackagesNgGen emacsPgtkGcc).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))
    mu
    binutils
    zstd
    emacs-all-the-icons-fonts
    rnix-lsp
    gnutls
    isync
    ispell
  ];

  xdg.configFile."emacs".source = config.lib.file.mkOutOfStoreSymlink
    (config.home.homeDirectory
      + ".nix-dotfiles/home-manager/modules/config/emacs");
}
