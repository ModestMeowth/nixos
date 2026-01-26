{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  hardware.raspberry-pi."4".apply-overlays-dtmerge.enable = true;

  boot = {
    initrd = {
      allowMissingModules = true;
      availableKernelModules = [ "xhci_pci" "usbhid" ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
