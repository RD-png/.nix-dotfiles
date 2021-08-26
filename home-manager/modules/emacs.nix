{ config, pkgs, inputs, ... }: {
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsPgtkGcc;
  home.packages = with pkgs; [
    emacsPgtkGcc
    mu
    binutils
    zstd
    emacs-all-the-icons-fonts
    rnix-lsp
    gnutls
  ];

  xdg.configFile."emacs".source = config.lib.file.mkOutOfStoreSymlink
    (config.home.homeDirectory
      + ".nix-dotfiles/home-manager/modules/config/emacs");
}
