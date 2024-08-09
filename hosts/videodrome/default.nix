{
  imports = [
    ./secrets.nix
    ./users.nix
  ];

  wsl = {
    wslConf = {
      network = {
        hostname = "videodrome";
        generateHosts = false;
        generateResolvConf = false;
      };
      user.default = "mm";
    };
    defaultUser = "mm";
  };

  networking = {
    nameservers = [
      "100.100.100.100"
    ];
    search = [
      "cat-alkaline.ts.net"
    ];
  };

  hostConfig = {
    hw.chassis = "wsl";
    hw.gpu = "headless";
    secrets.sops = true;
    utils.tailscale.enable = true;
  };
}
