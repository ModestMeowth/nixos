{ezModules, lib, ...}:
{
  imports = [
    ezModules.shares
    ezModules.tailscale
    ezModules.unstable
    ezModules.wsl

    ./hardware-configuration.nix
    ./secrets.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "mm";
    startMenuLaunchers = true;
    useWindowsDriver = true;

    wslConf = {
      user.default = "mm";
      network = {
        generateHosts = false;
        generateResolvConf = false;
      };
    };
  };

  environment.shellAliases.nvidia-smi = "NIX_LD_LIBRARY_PATH=/usr/lib/wsl/lib /usr/lib/wsl/lib/nvidia-smi";

  networking = {
    firewall.enable = lib.mkForce false;
    nftables.enable = lib.mkForce false;

    hostName = "videodrome";

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    search = [
      "cat-alkaline.ts.net"
      "home.arpa"
    ];
  };

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;
  };

  shares.pwnyboy-media.enable = true;
}
