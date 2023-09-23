{ inputs, config, system, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.ryan = {
      xdg.enable = true;
      home = {
        stateVersion = config.system.stateVersion;
        username = "ryan";
        homeDirectory = "/home/ryan";
      };
      imports = builtins.map
        (module: ./modules/${module})
        (builtins.attrNames (builtins.readDir ./modules));
    };
  };
}
