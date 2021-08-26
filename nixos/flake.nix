{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    xmonad = {
      url = "github:IvanMalison/xmonad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xmonad-contrib = {
      url = "github:IvanMalison/xmonad-contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, emacs, xmonad
    , xmonad-contrib, ... }:
    let
      system = "x86_64-linux";

      config.allowUnfree = true;

      overlays = with inputs;
        [
          emacs.overlay
          # xmonad.overlay
          # xmonad-contrib.overlay
        ];

    in {

      nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          # { nixpkgs.overlays = [ emacs.overlay ]; }
        ];
      };

      nixos-desktop =
        self.nixosConfigurations.nixos-desktop.config.system.build.toplevel;
    };
}
