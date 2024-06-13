{
  networking.firewall.allowedTCPPorts = [
    6443
    8080
  ];

  services.k3s = {
    enable = true;
    role = "server";
  };
}
