{ hostname, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./secrets.nix
    ./users.nix
  ];

  wsl.wslConf.network = {
    hostname = hostname;
    generateHosts = false;
    generateResolvConf = false;
  };

  networking = {
    nameservers = [ "100.100.100.100" ];
    search = [ "cat-alkaline.ts.net" ];
  };

  modules.services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };

  modules.services.ssh.enable = true;

  modules.shares.pwnyboy-share = {
    enable = true;
  };
}
