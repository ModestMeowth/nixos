{ ezModules, inputs, ... }:
let
  wlan = "wlan0";
in
{
  imports = with ezModules; [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4

    cockpit
    rpi
    tailscale
    unstable

    ./hardware-configuration.nix
  ];

  hardware.raspberry-pi."4" = {
    apply-overlays-dtmerge.enable = true;
    poe-plus-hat.enable = true;
  };

  networking = {
    hostName = "skinman";
    networkmanager.ensureProfiles.profiles = {
      "Ponyboy Bounce House".connection = {
        autoconnect = false;
        interface-name = wlan;
      };
    };
  };

  services = {
    cockpit.allowed-origins = [
      "https://skinman:9090"
      "https://skinman.threefinger.farm"
      "https://skinman.cat-alkaline.ts.net:9090"
    ];

    technitium-dns-server = {
      enable = true;
      openFirewall = true;
    };
  };
}
