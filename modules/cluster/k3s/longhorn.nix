{ config, lib, pkgs, ... }: {
  options.hostConfig.cluster.k3s-longhorn = lib.mkEnableOption "k3s-longhorn";

  config = lib.mkIf config.hostConfig.cluster.k3s {
    environment.systemPackages = [ pkgs.nfs-utils ];

    services = {
      tmpfiles.rules = [
        "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
      ];

      openiscsi = {
        enable = true;
        name = "{config.networking.hostName}-initiatorHost";
      };
    };
  };
}
