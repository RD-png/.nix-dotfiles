{ inputs, config, pkgs, lib, ... }: {
  imports = [ ./home.nix ./hardware-configuration.nix ];

  networking.hostName = "nixos-work";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub.enable = true;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
  };

  # services = {
  #   cron = {
  #     enable = true;
  #     systemCronJobs = [
  #       "10 * * * * root  ${pkgs.php}/bin/php /var/htdocs/Projects/Stock_Test_env/pull_api_orders.php"
  #     ];
  #   };
  # };

  fileSystems."/mnt/deepthought" = {
    device = "//192.168.0.24/wwwroot";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=2.0,dir_mode=0777,file_mode=0777,nounix,nobrl";

    in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  };

  fileSystems."/mnt/fesp_apache" = {
    device = "//192.168.0.24/htdocs";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=2.0,dir_mode=0777,file_mode=0777,nounix,nobrl";

    in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  };

  fileSystems."/mnt/elixir" = {
    device = "vova@192.168.0.125:/";
    fsType = "fuse.sshfs";
    noCheck = true;
    options =
      [
        "x-systemd.automount"
        "reconnect"
        "_netdev"
        "user"
        "idmap=user"
        "transform_symlinks"
        "IdentityFile=/home/ryan/.ssh/id_rsa"
        "allow_other"
        "default_permissions"
        "uid=1000"
        "gid=1000"
      ];
  };

  # System default packages
  environment.systemPackages = with pkgs; [ sshfs ];
}
