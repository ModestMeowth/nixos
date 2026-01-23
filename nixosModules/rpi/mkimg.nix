{lib, modulesPath, ...}:
let
  wlan = "wlan0";
in
{
  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = "aarch64-linux";

  sdImage.compressImage = false;
  nix.settings.experimental-features = "nix-command flakes";

  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64-installer.nix"
    ../networkmanager.nix
  ];

  networking = {
    hostId = "00bab10c";
    networkmanager = {
      enable = true;
      ensureProfiles.profiles."Ponyboy Bounce House".connection.interface-name = wlan;
    };
  };

  programs = {
    git.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  services.tailscale.enable = true;

  users.users.nixos.initialHashedPassword = lib.mkForce "$y$j9T$DQT1KD1SVuoKLGNg1STB..$27jCRv1NsVWVMk94JSBQQknLjJzgq88.stwN0NdedTD";
}
