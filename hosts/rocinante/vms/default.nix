{
  imports = [
    ./networks.nix
    ./storage.nix

    ./talos1.nix
    ./talos2.nix
    ./talos3.nix
  ];

  modules.virt.enable = true;
}
