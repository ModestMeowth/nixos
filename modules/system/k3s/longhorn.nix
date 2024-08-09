{
  config,
  pkgs,
  ...
}: {
  # See https://nixos.wiki/wiki/K3s#Longhorn for setup
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  services.openiscsi = {
    enable = true;
    name = "${config.networking.hostname}-initiatorhost";
  };
}
