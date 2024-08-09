{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hostConfig.secrets = {
    sops = lib.mkEnableOption "sops";
  };

  config = lib.mkIf config.hostConfig.secrets.sops {
    sops = {
      defaultSopsFile = ../../../secrets.yaml;
      age = {
        generateKey = true;
        keyFile = "/var/lib/sops-nix/key.txt";
      };
    };

    environment.systemPackages = with pkgs; [
      age
      sops
    ];
  };
}
