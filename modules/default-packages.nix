{ config, pkgs, libs, ... }: {
  home.packages = with pkgs; [
    ## General
    gnome-icon-theme
    xfce.tumbler
    xfce.thunar
    xfce.xfconf
    xfce.exo
    alacritty
    discord
    sublime4
    inkscape
    firefox
    brave
    libvterm
    flameshot

    ## Programming
    texlive.combined.scheme-full
    haskell-language-server
    sqlitebrowser
    postgresql
    nix-direnv
    direnv
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
    go
    gopls
    erlang
    erlang-ls
    ocaml
    ocamlPackages.ocaml-lsp
    
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
    yarn

    ## Utils
    # pkgs.nur.repos.reedrw.picom-next-ibhagwan
    (ripgrep.override { withPCRE2 = true; })
    pavucontrol
    neofetch
    openssh
    exa    
    picom
    sshfs
    unzip    
    htop
    wget
    tldr
    bat    
    feh
    fd
    sd
  ];
}
