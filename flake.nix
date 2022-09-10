{
  inputs = {
    nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    nur.url = "github:nix-community/NUR";

    # Overlays
    emacs.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs@{ self, ... }:
    with inputs;
    let
      system = "x86_64-linux";

      nixUserFlake = host:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            host
            ./system.nix
            ./home.nix
          ];
        };

      nixosConfiguration = host:
        {
          name = host;
          value = nixUserFlake { imports = [ (import ./hosts/${host}) ]; };
        };
    in
    {
      nixosConfigurations = builtins.listToAttrs (builtins.map
        nixosConfiguration
        (builtins.attrNames (builtins.readDir ./hosts)));

      devShells."${system}".default =
        import ./shell.nix { inherit pkgs; };
    };
}
