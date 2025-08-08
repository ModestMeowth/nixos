{ config, pkgs, ...}: {
  imports = [
    ./secrets.nix
    ./hardware.nix
  ];

  networking = {
    hostName = "rocinante";

    search = [ "cat-alkaline.ts.net" "home.arpa" ];

    firewall.trustedInterfaces = [ "tailscale0" "docker0" ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      ensureProfiles.profiles = {
        "Ponyboy Bounce House".connection.interface-name = "wlp2s0";
        "Hyrule".connection.interface-name = "wlp2s0";
      };
    };
  };

  services = {
    chrony.enable = true;
    fwupd.enable = true;

    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraSetFlags = [ "--ssh" "--webclient" "--accept-routes" ];
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

  environment.systemPackages = with pkgs; [ smartmontools samba ];

  gaming = {
    emulation.enable = true;
    ffxiv.enable = true;
    steam.enable = true;
  };
}
