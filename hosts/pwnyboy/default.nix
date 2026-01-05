{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./secrets.nix
  ];

  networking = {
    hostName = "pwnyboy";
    search = [ "threefinger.farm" ];
    useDHCP = false;

    bonds.bond0 = {
      interfaces = [ "enp3s0" "enp4s0" ];
      driverOptions = {
        miimon = "100";
        mode = "active-backup";
      };
    };

    bridges.bridge0.interfaces = [ "bond0" ];

    interfaces.bridge0 = {
      macAddress = "a8:b8:e0:05:a6:02";
      useDHCP = true;
    };

    localCommands = ''
      ip rule add to 192.168.0.0/24 table main priority 1000
    '';

    firewall = {
      trustedInterfaces = [ "tailscale0" ];

      allowedTCPPorts = [
        80
        443 # HTTP
        8123 # HomeAssistant
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
      extraUpFlags = [ "--ssh" "--operator=mm" "--accept-routes" "--reset" ];
      extraSetFlags = [ "--ssh" "--operator=mm" "--accept-routes" ];
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

  environment.systemPackages = with pkgs; [ docker-compose ];

  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
  };

  systemd.services."libvirt-guests".enable = lib.mkForce false;
}
