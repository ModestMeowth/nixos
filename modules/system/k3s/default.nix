{
# https://nixos.wiki/wiki/K3s#Single_node_setup
  services.k3s = {
    enable = true;
    role = "server";
  };

  networking.firewall = {
    allowedTCPPorts = [
      6443
    ];
    allowedUDPPorts = [
      6443
    ];
  };
}
