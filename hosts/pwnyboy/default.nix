{ config, lib, pkgs, ... }:
let
  bridge = "bridge0";
  cidr = "192.168.0";
  prefix = 24;
in {
  imports = [
    ./hardware.nix
    ./secrets.nix
  ];

  networking = {
    hostName = "pwnyboy";
    bridges."${bridge}".interfaces = [ "enp3s0" ];

    useDHCP = false;

    interfaces."${bridge}".ipv4.addresses = [{
      address = "${cidr}.30";
      prefixLength = prefix;
    }];

    defaultGateway = {
      address = "${cidr}.1";
      interface = "${bridge}";
    };

    nameservers = [ "${cidr}.1" "1.1.1.1" ];

    firewall = {
      trustedInterfaces = [ "tailscale0" "docker0" ];

      allowedTCPPorts = [
        80
        443 # HTTP
        53
        853 # DNS over TCP
        5000 # nix-serve
        8123 # HomeAssistant
        22000 # Syncthing
      ];

      allowedUDPPorts = [
        53 # DNS
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
      extraSetFlags = [ "--ssh" "--webclient" "--accept-routes" ];
    };

    fwupd.enable = true;

    nix-serve.enable = true;
    nix-serve.secretKeyFile = config.sops.secrets."cache-priv-key".path;
    nix-serve.openFirewall = true;

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
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  systemd.services."libvirt-guests".enable = lib.mkForce false;
}
