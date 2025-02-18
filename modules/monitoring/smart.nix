{ pkgs, ... }: {
  services.prometheus.exporters.smartctl = {
    enable = true;
    openFirewall = true;
  };

  services.smartd.enable = true;

  environment.systemPackages = with pkgs; [
    pciutils
    smartmontools
  ];
}
