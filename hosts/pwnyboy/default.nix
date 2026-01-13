{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./secrets.nix
  ];

  networking = {
    hostName = "pwnyboy";
    search = [ "threefinger.farm" ];
    useDHCP = false;

    bridges.bridge0.interfaces = [ "enp3s0" "enp4s0" ];

    interfaces = {
      enp3s0.wakeOnLan.enable = true;
      enp4s0.wakeOnLan.enable = true;
      bridge0.ipv4.addresses = [
        {
          address = "192.168.1.30";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "bridge0";
    };

    nameservers = [
      "192.168.1.1"
    ];

    firewall = {
      trustedInterfaces = [ "tailscale0" ];

      allowedTCPPorts = [
        443
        8081
        8083 # MQTT Websocket
        8123 # HomeAssistant

        8883 # MQTT
        22000 # Syncthing
      ];

      allowedUDPPorts = [
        22000
        21027 # Syncthing
      ];
    };
  };

  services = {
    chrony.enable = true;

    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraUpFlags = [ "--ssh" "--operator=mm" "--reset" ];
      extraSetFlags = [ "--ssh" "--operator=mm" ];
      useRoutingFeatures = "client";

      openFirewall = true;
    };

    fwupd.enable = true;

    samba.enable = true;
    samba.openFirewall = true;

    samba.settings.global = {
      "workgroup" = "WORKGROUP";
      "server string" = "pwnyboy";
      "netbios name" = "pwnyboy";

      "security" = "user";
      "guest account" = "nobody";
      "map to guest" = "bad user";

      "mangled names" = "no";
      "vfs objects" = "catia";
      "catia:mappings" = "0x3a:0x5f";
    };

    samba-wsdd.enable = true;
    samba-wsdd.openFirewall = true;

    samba.settings.media = {
      "path" = "/persist/data/media";
      "public" = "yes";
      "browsable" = "yes";
      "read only" = "no";
      "writeable" = "yes";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "mm";
      "force group" = "users";
    };
  };

  power.ups = {
    enable = true;

    upsmon.settings = {
      MINSUPPLIES = 0;
      POWERDOWNFLAG = null;
    };

    ups."apc" = {
      driver = "usbhid-ups";
      port = "auto";
      directives = [ "vendorid = 051d" "productid = 0002" ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      package = pkgs.unstable.docker;
    };
  };
}
