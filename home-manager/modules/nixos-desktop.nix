{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    # General
    firefox
    sqlitebrowser
    discord
    spotify
    # Programming
    gcc
    nodejs
    nodePackages.npm
    php
    haskell-language-server
    ghc
    python-language-server
    python39Full
    python39Packages.pylint
    nixfmt
    # Utils
    unzip
    (ripgrep.override { withPCRE2 = true; })
    fd
  ];
}
