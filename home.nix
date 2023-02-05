{ inputs, config, home-manager, overlay-stable, ... }: {
  home-manager = {
    useUserPackages = true;
    users.ryan = {
      xdg.enable = true;
      home = {
        stateVersion = config.system.stateVersion;
        username = "ryan";
        homeDirectory = "/home/ryan";
      };
      nixpkgs = {
        config.allowUnfree = true;
        overlays = [ inputs.emacs.overlay inputs.nur.overlay overlay-stable ];
      };
      imports = builtins.map
        (module: ./modules/${module})
        (builtins.attrNames (builtins.readDir ./modules));
    };
  };
}
