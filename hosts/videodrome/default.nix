{hostname, pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./secrets.nix
    ./users.nix
  ];

  wsl = {
    wslConf = {
      network = {
        hostname = hostname;
        generateHosts = false;
        generateResolvConf = false;
      };
    };
  };

  networking = {
    nameservers = [
      "100.100.100.100"
    ];
    search = [
      "cat-alkaline.ts.net"
    ];
  };

  modules.services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };
}
