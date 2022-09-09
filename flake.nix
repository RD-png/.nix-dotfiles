{
  inputs = {
    # Nix
    nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NUR
    nur.url = "github:nix-community/NUR";

    # Overlays
    emacs.url = "github:nix-community/emacs-overlay";

    # Misc
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs@{ self, ... }:
    with inputs;
    let
      system = "x86_64-linux";
      mkPkgs = pkgs:
        import pkgs {
          inherit system;
          config.allowUnfree = true;
        };
      pkgs = mkPkgs nixpkgs;

      nixUserFlake = host:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs inputs system; };
          modules = [
            {
              home-manager.useUserPackages = true;
              home-manager.users.ryan = {
                xdg.enable = true;
                home.stateVersion = "22.05";
                home.username = "ryan";
                home.homeDirectory = "/home/ryan";
                nixpkgs.config.allowUnfree = true;
                nixpkgs.overlays = [ emacs.overlay nur.overlay ];
                imports = builtins.map (module: ./modules + "/${module}")
                  (builtins.attrNames (builtins.readDir ./modules));
              };
            }
            ./system.nix
            host
            home-manager.nixosModules.home-manager
          ];
        };

    in
    {
      nixosConfigurations = builtins.listToAttrs (builtins.map
        (host: {
          name = host;
          value = nixUserFlake {
            imports = [ (import (./hosts + "/${host}/configuration.nix")) ];
          };
        })
        (builtins.attrNames (builtins.readDir ./hosts)));

      devShells."${system}".default =
        import ./shell.nix { inherit pkgs; };
    };
}
