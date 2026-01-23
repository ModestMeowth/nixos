{modulesPath, ...}:
let
  wlan = "wlan0";
in
{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    ../networkmanager.nix
  ];
  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = "aarch64-linux";
  nix.settings.experimental-features = "nix-command flakes";

  networking.networkmanager = {
    enable = true;
    ensureProfiles.profiles."Ponyboy Bounce House".connection.interface-name = wlan;
  };

  services = {
    cockpit.enable = true;
    cockpit.openFirewall = true;
  };
}
