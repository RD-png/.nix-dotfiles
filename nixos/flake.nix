{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };

    in {

      nixosConfigurations = {
        nixos-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos-desktop/configuration.nix
            ./configuration.nix
          ];
        };

        nixos-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos-laptop/configuration.nix
            ./configuration.nix
          ];
        };

        nixos-work = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos-work/configuration.nix
            ./configuration.nix
          ];
        };
      };

      nixos-desktop =
        self.nixosConfigurations.nixos-desktop.config.system.build.toplevel;
      nixos-laptop =
        self.nixosConfigurations.nixos-laptop.config.system.build.toplevel;
      nixos-work =
        self.nixosConfigurations.nixos-work.config.system.build.toplevel;
    };
}
