{ config, pkgs, ... }: {
  boot = {
    supportedFilesystems.zfs = true;
    zfs.forceImportRoot = false;
  };

  # ZFSBootMenu
  networking.hostId = "00bab10c";

  services = {
    lvm.enable = false;
    zfs.autoScrub.enable = true;
    zfs.autoScrub.interval = "Sun, 2:00:00";
    zfs.autoScrub.randomizedDelaySec = "3h";
    zfs.trim.enable = true;

    sanoid.enable = true;
    sanoid.templates = {
      default.autoprune = true;
      default.autosnap = true;

      default.hourly = 36;
      default.daily = 30;
      default.monthly = 3;
    };

    smartd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pciutils
    smartmontools
    (writeShellScriptBin "sanoid" ''
      ${config.systemd.services.sanoid.serviceConfig.ExecStart} $@
    '')
  ];
}
