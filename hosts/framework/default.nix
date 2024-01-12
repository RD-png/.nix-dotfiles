{ inputs, config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./home.nix ];

  networking.hostName = "framework";

  services = {
    xserver = {
      libinput = {
        touchpad = {
          accelSpeed = "0.2";
        };
      };
    };
  };
}
