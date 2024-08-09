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
    nameserver = [
      "100.100.100.100"
    ];
    search = [
      "cat-alkaline.ts.net"
    ];
  };
}
