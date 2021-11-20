{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    # General
    gnome-icon-theme
    xfce.tumbler
    xfce.thunar
    xfce.xfconf
    xfce.exo
    alacritty
    sublime4
    firefox

    # Programming
    texlive.combined.scheme-full
    haskell-language-server
    sqlitebrowser
    sqlite
    nixfmt
    nodejs
    pipenv
    vim
    git
    gcc
    ghc
    php
    # Python packages
    python39Packages.python-lsp-server
    python39Packages.setuptools
    python39Packages.virtualenv
    python39Packages.ipython
    python39Packages.pylint
    python39Packages.flake8
    python39Packages.black
    python39Packages.pip
    python39Full
    # Node packages
    nodePackages.npm
    nodePackages.vls
    nodePackages."@vue/cli"

    # Utils
    (ripgrep.override { withPCRE2 = true; })
    pavucontrol
    neofetch
    openssh
    sshfs    
    dmenu
    unzip
    htop
    wget
    tldr
    bat
    fd
    sd
  ];
}
