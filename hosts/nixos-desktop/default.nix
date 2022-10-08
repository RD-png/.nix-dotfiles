{ inputs, config, pkgs, lib, ... }: {
  imports = [
    ./home.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-desktop";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
  };

  hardware = {
    cpu = {
      amd = {
        updateMicrocode = true;
      };
    };
    bluetooth = {
      enable = true;
    };
  };

  services = {
    autorandr = {
      enable = true;
      # defaultTarget =
      profiles = {
        "desktop" = {
          fingerprint = {
            "DisplayPort-0" = "00ffffffffffff000469a42401010101281d0104a5351e783a9de5a654549f260d5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c4500132b2100001e000000fd0032961ea021000a202020202020000000fc0056473234380a20202020202020000000ff004b394c4d51533130363635330a01a0020318f14b900504030201111213141f2309070783010000023a801871382d40582c4500132b2100001e8a4d80a070382c4030203500132b2100001afe5b80a07038354030203500132b2100001a866f80a07038404030203500132b2100001afc7e80887038124018203500132b2100001e0000000000000000000000000073";
            "DisplayPort-1" = "00ffffffffffff0004720d049df7204216180104a5301b782284d5a25a52a2260d5054b30c00d1c0b30095008180810081c0714f0101023a801871382d40582c4500dd0c1100001e000000fd00374c1e5311000a202020202020000000ff0054314c4545303031343230300a000000fc0041636572204b32323248514c0a00d6";
          };
          config = {
            "DisplayPort-0" = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "1920x1080";
              rate = "144.00";
            };
            "DisplayPort-1" = {
              enable = true;
              position = "1920x0";
              mode = "1920x1080";
            };
          };
        };
      };
    };
  };
}
