{
  networking.hostName = "rocinante";

  imports = [
    ./filesystems.nix
    ./hardware.nix
    ./secrets.nix
    ./services.nix
    ./users.nix
#    ./vms
  ];
}
