{ config, pkgs, ... }: {
  services = {
    chrony.enable = true;

    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraSetFlags = [
        "--ssh"
        "--webclient"
      ];
    };

    fwupd.enable = true;

    nix-serve.enable = true;
    nix-serve.secretKeyFile = config.sops.secrets."cache-priv-key".path;
    nix-serve.openFirewall = true;
  };

  monitoring.enable = true;

  power.ups = {
    enable = true;

    upsmon.settings = {
      MINSUPPLIES = 0;
      POWERDOWNFLAG = null;
    };

    ups."apc" = {
      driver = "usbhid-ups";
      port = "auto";
      directives = [
        "vendorid = 051d"
        "productid = 0002"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  virtualisation = {
    docker.enable = true;
    libvirt.enable = true;
  };
}
