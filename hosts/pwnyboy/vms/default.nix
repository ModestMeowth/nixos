{
  imports = [
    #    ./i915-sriov.nix

    ./networks.nix
    ./storage.nix

    #    ./talos1.nix
    #    ./talos2.nix
    #    ./talos3.nix
  ];

  virtualisation.libvirt.enable = true;
}
