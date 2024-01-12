{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };
    };
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
  };

  hardware = {
    trackpoint = {
      enable = true;
      emulateWheel = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6fbd9d6a-f8e5-4c71-9be9-7da22bf3b4e2";
    fsType = "ext4";
  };
}
