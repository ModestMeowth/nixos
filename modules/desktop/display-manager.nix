{ pkgs, ... }: {
  services = {
    udisks2.enable = true;
    gvfs.enable = true;

    xserver = {
      enable = true;

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  systemd.services.udisks2.wantedBy = [ "graphical-session.target" ];

  environment.systemPackages = with pkgs; [ gvfs ];
}
