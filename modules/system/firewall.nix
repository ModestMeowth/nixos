{
  networking.firewall = {
    enable = true;
    trustedInterfaces = [
      "tailscale0"
    ];
  };
}
