{ inputs, config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./home.nix ];

  networking.hostName = "framework";

  services = {
    xserver = {
      dpi = 144;
      upscaleDefaultCursor = true;
      libinput = {
        touchpad = {
          accelSpeed = "0.3";
          disableWhileTyping = true;
        };
      };
    };
    picom = {
      vSync = true;
    };
  };
}
