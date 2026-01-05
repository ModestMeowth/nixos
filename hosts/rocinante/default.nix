{ config, pkgs, ...}: let
  wlan = "wlp2s0";
in {
  imports = [
    ./secrets.nix
    ./hardware.nix
  ];

  networking = {
    hostName = "rocinante";
    search = [ "threefinger.farm" ];
    firewall.trustedInterfaces = [ "tailscale0" ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      ensureProfiles.profiles = {
        "Ponyboy Bounce House".connection.interface-name = wlan;
        "Hyrule".connection.interface-name = wlan;
      };
    };
  };

  services = {
    auto-cpufreq = {
      enable = true;
      settings.battery = {
        governor = "powersave";
        turbo = "never";
      };
      settings.charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
    chrony.enable = true;
    fwupd.enable = true;

    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraUpFlags = [ "--ssh" "--operator=mm" "--accept-routes" "--reset" ];
      extraSetFlags = [ "--ssh" "--operator=mm" "--accept-routes" ];
      useRoutingFeatures = "client";
    };

    smartd.enable = true;
    fprintd.enable = true;

    resolved = {
      enable = true;
      dnssec = "true";
      dnsovertls = "opportunistic";
      extraConfig = # ini
        ''
          [Resolve]
          MulticastDNS=yes
        '';
    };
  };

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [ smartmontools samba ];

  gaming = {
    emulation.enable = true;
    ffxiv.enable = true;
    steam.enable = true;
  };

  virtualisation.docker.enable = true;
}
