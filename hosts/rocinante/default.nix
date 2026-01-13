{ config, pkgs, ...}: let
  wlan = "wlp2s0";
in {
  imports = [
    ./secrets.nix
    ./hardware.nix
  ];

  networking = {
    hostName = "rocinante";
    firewall.trustedInterfaces = [ "tailscale0" ];

    networkmanager = {
      enable = true;
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
      extraUpFlags = [ "--ssh" "--operator=mm" "--reset" ];
      extraSetFlags = [ "--ssh" "--operator=mm" ];
      useRoutingFeatures = "client";
    };

    pcscd.enable = true;

    smartd.enable = true;
    fprintd.enable = true;
  };

  programs.kdeconnect.enable = true;
  programs.yubikey-manager.enable = true;

  environment.systemPackages = with pkgs; [ smartmontools samba ];

  gaming = {
    emulation.enable = true;
    steam.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    package = pkgs.unstable.docker;
  };
}
