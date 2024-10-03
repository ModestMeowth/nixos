{ config, lib, pkgs, ... }: {
  options.hostConfig.cluster.k3s-longhorn = lib.mkEnableOption "k3s-longhorn";

  config = lib.mkIf config.hostConfig.cluster.k3s {
    boot.supportedFilesystems = [ "nfs" ];

    environment.systemPackages = [ pkgs.nfs-utils ];

    services = {
      openiscsi = {
        enable = true;
        name = "{config.networking.hostName}-initiatorHost";
      };

      rpcbind.enable = true;
    };

    systemd.tmpfiles.rules = [
      "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
    ];
  };
}
