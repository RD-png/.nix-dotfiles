{
  description = "Home-manager configuration flake";

  inputs = {
    # Channels
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Pkg overlays
    emacs.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      config.allowUnfree = true;

      overlays = with inputs; [ emacs.overlay ];

    in {
      homeConfigurations = {
        nixos-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          inherit system;
          configuration = { pkgs, ... }: {
            nixpkgs.config = config;
            nixpkgs.overlays = overlays;
            imports = [
              ./modules/default-packages.nix
              ./modules/nixos-desktop.nix
              ./modules/home-manager.nix
              ./modules/emacs.nix
              ./modules/xmonad.nix
              ./modules/dotfiles.nix
            ];
          };
          homeDirectory = "/home/ryan/";
          username = "ryan";
        };

        nixos-work = inputs.home-manager.lib.homeManagerConfiguration {
          inherit system;
          configuration = { pkgs, ... }: {
            nixpkgs.config = config;
            nixpkgs.overlays = overlays;
            imports = [
              ./modules/default-packages.nix
              ./modules/nixos-work.nix
              ./modules/home-manager.nix
              ./modules/emacs.nix
              ./modules/xmonad.nix
              ./modules/dotfiles.nix
            ];
          };
          homeDirectory = "/home/ryan/";
          username = "ryan";
        };
      };
      nixos-desktop = self.homeConfigurations.nixos-desktop.activationPackage;
      nixos-work = self.homeConfigurations.nixos-work.activationPackage;
    };
}
