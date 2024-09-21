{
  config,
  lib,
  ...
}: {

  options.hostConfig.cluster.k3s = lib.mkEnableOption "k3s";

  config = lib.mkIf config.hostConfig.cluster.k3s {
    networking.firewall = {
      allowedTCPPorts = [
        443
        6443
      ];

      allowedUDPPorts = [
      ];
    };

    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = toString [
        "--write-kubeconfig-mode 0640"
        "--cluster-init"
      ];
    };

    systemd.tmpfiles.rules = [
      "f /etc/rancher/k3s/k3s.yaml 0640 root wheel -"
    ];
  };
}
