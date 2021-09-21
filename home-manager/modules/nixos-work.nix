{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    firefox
    sqlitebrowser
    gcc
    nodejs
    nodePackages.npm
    nodePackages.typescript-language-server
    nodePackages.vls
    nodePackages."@vue/cli"
    php
    ghc
    postman
    python39Packages.python-lsp-server
    python39Packages.python-lsp-server
    python39Full
    python39Packages.setuptools
    python39Packages.ipython
    python39Packages.pylint
    python39Packages.pip
    python39Packages.flake8
    python39Packages.black
    python39Packages.virtualenv
    pipenv
    nixfmt
    unzip
    (ripgrep.override { withPCRE2 = true; })
    fd
  ];
}
