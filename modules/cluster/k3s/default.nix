{
  config,
  lib,
  ...
}: {

  imports = [
    ./longhorn.nix
  ];

  options.hostConfig.cluster.k3s = lib.mkEnableOption "k3s";

  config = lib.mkIf config.hostConfig.cluster.k3s {
    networking.firewall = {
      allowedTCPPorts = [
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
      ];
    };

    systemd.tmpfiles.rules = [
      "f /etc/rancher/k3s/k3s.yaml 0640 root wheel -"
    ];
  };
}
