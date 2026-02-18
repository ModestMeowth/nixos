{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot = {
    supportedFilesystems.zfs = true;
    zfs.forceImportRoot = false;
  };

  environment.systemPackages = with pkgs; [
    pciutils
    smartmontools
    (writeShellScriptBin "sanoid" ''
      ${config.systemd.services.sanoid.serviceConfig.ExecStart} $@
    '')
  ];

  networking.hostId = "00bab10c";

  services = {
    lvm.enable = lib.mkDefault false;

    sanoid = {
      enable = true;
      templates.default = {
        autoprune = true;
        autosnap = true;
        hourly = 24;
        daily = 30;
        monthly = 12;
      };
    };

    smartd.enable = true;

    zfs = {
      autoScrub = {
        enable = true;
        interval = "Sun, 2:00:00";
        randomizedDelaySec = "3h";
      };
      trim.enable = true;
    };
  };
}
