{ config, pkgs, libs, ... }: {

  # services.picom.package = pkgs.picom.overrideAttrs (old: {
  #   src = builtins.fetchTarball {
  #     url = "https://github.com/ibhagwan/picom/archive/next.tar.gz";
  #     sha256 = "1z51xk9vdy5l925msmprmhzjis516h76id2qhdswf916ssjgxl6m";
  #   };
  # });

  home.packages = with pkgs; [
    # General
    gnome-icon-theme
    xfce.tumbler
    xfce.thunar
    xfce.xfconf
    xfce.exo
    alacritty
    sublime4
    brave
    firefox

    # Programming
    texlive.combined.scheme-full
    haskell-language-server
    sqlitebrowser
    sqlite
    nixfmt
    nodejs
    pipenv
    cargo
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
    pkgs.nur.repos.reedrw.picom-next-ibhagwan # Picom override
    (ripgrep.override { withPCRE2 = true; })
    pavucontrol
    neofetch
    openssh
    polybar
    glxinfo
    sshfs
    unzip
    rofi
    htop
    wget
    tldr
    bat
    exa
    fd
    sd
  ];
}
