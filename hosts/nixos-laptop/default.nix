{ inputs, config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./home.nix ];

  networking.hostName = "nixos-laptop";

  services = {
    xserver = {
      libinput = {
        touchpad = {
          sendEventsMode = "disabled";
        };
      };
    };
  };
}
