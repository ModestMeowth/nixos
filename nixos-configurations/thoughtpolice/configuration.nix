{ezModules, pkgs, ...}:
{
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "thoughtpolice";

  imports = with ezModules; [
    efi
    gaming
    hyprland
    kmscon
    nvidia
    shares
    tailscale
    unstable
    wireless
    zfs

    ./hardware-configuration.nix
    ./secrets.nix
  ];
}
