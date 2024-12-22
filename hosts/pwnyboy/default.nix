{
  networking.hostName = "pwnyboy";

  imports = [
    ./filesystems.nix
    ./hardware.nix
    ./networks.nix
    ./samba
    ./secrets.nix
    ./services.nix
    ./users.nix
    ./vms
  ];
}
