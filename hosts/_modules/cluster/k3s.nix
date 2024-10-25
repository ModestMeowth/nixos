{ config
, lib
, pkgs
, ...
}:
with lib;
let

  cfg = config.modules.cluster.k3s;

in
{

  options.modules.cluster.k3s = {
    enable = mkEnableOption "k3s";

    package = mkPackageOption pkgs "k3s" { };

    role = mkOption {
      type = types.enum [
        "agent"
        "server"
      ];
      default = "server";
    };

    extraFlags = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Extra flags to pass to k3s";
    };

  };

  config = mkIf cfg.enable {

    # rook-ceph
    boot.kernelModules = [ "rdb" ];
    boot.supportedFilesystems = [ "nfs" ];

    services.rpcbind.enable = true;

    networking.firewall.allowedTCPPorts = [ 6443 ];

    services.k3s = {
      enable = true;
      inherit (cfg) package role;
    };

    services.k3s.extraFlags = toString (
      [
        "--disable local-storage"
        "--disable traefik"
        "--disable metrics-server"
        "--flannel-backend=none"
        "--disable-network-policy"
      ]
      ++ cfg.extraFlags
    );

  };
}
