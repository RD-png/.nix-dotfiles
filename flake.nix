{
  inputs = {
    nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Overlays
    emacs.url = "github:nix-community/emacs-overlay";
    nur.url = "github:nix-community/NUR";
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
        import ./shell.nix;
    };
}
