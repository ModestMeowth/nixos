{
  config,
  lib,
  ...
}: {
  options.hostConfig.programs = {
    syncthing = lib.mkEnableOption "syncthing";
  };

  config = lib.mkIf config.hostConfig.programs.syncthing {
    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [21027];
    };

    services.syncthing.enable = true;
  };
}
