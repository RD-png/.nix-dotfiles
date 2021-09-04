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
    # nodePackages.vls
    nodePackages.typescript-language-server
    nodePackages.vls
    nodePackages."@vue/cli"
    php
    haskell-language-server
    ghc
    python38Packages.python-language-server
    python39Full
    python39Packages.pylint
    nixfmt
    # Utils
    unzip
    (ripgrep.override { withPCRE2 = true; })
    fd
  ];
}
