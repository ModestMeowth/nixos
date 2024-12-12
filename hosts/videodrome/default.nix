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
    useWindowsDriver = true;
  };

  networking = {
    nameservers = [ "100.100.100.100" ];
    search = [ "cat-alkaline.ts.net" ];
  };

  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };

  modules.services.ssh.enable = true;

  modules.shares.pwnyboy-share = {
    enable = true;
  };

  hardware.opengl = {
    #    setLdLibraryPath = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = [ pkgs.unstable.linuxPackages.nvidia_x11 ];
    package = pkgs.unstable.nix-ld;
  };
}
