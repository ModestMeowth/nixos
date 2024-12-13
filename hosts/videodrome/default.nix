{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./secrets.nix
    ./users.nix
  ];

  wsl.wslConf.network = {
    hostname = "videodrome";
    generateHosts = false;
    generateResolvConf = false;
    useWindowsDriver = true;
  };

  networking = {
    nameservers = [ "100.100.100.100" ];
    search = [ "cat-alkaline.ts.net" ];
  };

  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    #    authKeyFile = config.sops.secrets."tskey".path;
  };

  modules.services.ssh.enable = true;

  services.prometheus.exporters.node.enable = true;

  modules.shares.pwnyboy-share = {
    enable = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = [ pkgs.unstable.linuxPackages.nvidia_x11 ];
    package = pkgs.unstable.nix-ld;
  };
}
