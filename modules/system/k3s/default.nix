{
  networking.firewall.allowedTCPPorts = [
    6443
    8080
  ];

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = toString [
      "--flannel-backend=wireguard-native"
      "--write-kubeconfig-mode=644"
    ];
  };
}
