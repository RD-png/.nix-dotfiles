{
  inputs = {
    nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Overlays
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, ... }:
    with inputs;
    let
      system = "x86_64-linux";
      mkPkgs = pkgs: overlays:
        import pkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = overlays;
        };
      overlay-stable = final: prev: {
        stable = mkPkgs nixpkgs-stable [ ];
      };
      pkgs = mkPkgs nixpkgs [ nur.overlays.default overlay-stable ];

      nixUserFlake = host:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs inputs system; };
          modules = [
            {
              nixpkgs.pkgs = pkgs;
            }
            host
            ./system.nix
            ./home.nix

          ];
        };

      nixosConfiguration = host:
        let hostConfig = { imports = [ (import ./hosts/${host}) ]; };
        in
        {
          name = host;
          value = nixUserFlake hostConfig;
        };
    in
    {
      nixosConfigurations = builtins.listToAttrs (builtins.map
        nixosConfiguration
        (builtins.attrNames (builtins.readDir ./hosts)));

      devShells.${system}.default =
        import ./shell.nix { inherit pkgs; };
    };
}
