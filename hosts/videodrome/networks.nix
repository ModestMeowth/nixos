{
  wsl.wslConf.network = {
    hostname = "videodrome";
    generateHosts = false;
    generateResolvConf = false;
    useWindowsDriver = true;
  };

  networking = {
    nameservers = [ "100.100.100.100" ];
    search = [ "cat-alkaline.ts.net" ];

    # Tailscale breaks ssh without MTU 1500
    interfaces.eth0.mtu = 1500;
  };

  # Allow NOPASSWD to set MTU if it drifts
  security.sudo.extraRules = [
    {
      groups = ["wheel"];
      commands = [
        {
          command = "/run/current-system/sw/bin/ip link set dev eth0 mtu 1500";
          options = ["SETENV" "NOPASSWD"];
        }
      ];
    }
  ];
}
