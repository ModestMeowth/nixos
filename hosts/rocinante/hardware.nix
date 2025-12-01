{ config, modulesPath, pkgs, ... }: {
  imports = [ ("${modulesPath}/installer/scan/not-detected.nix") ];

  boot = {
    lanzaboote.enable = true;

    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];

    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  # Plymouth
  boot.initrd.verbose = false;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" ];

  hardware = {
    cpu.amd.updateMicrocode = true;

    graphics.enable = true;
    graphics.enable32Bit = true;

    amdgpu.initrd.enable = true;
    amdgpu.opencl.enable = true;
  };

  services = {
    xserver.videoDrivers = [ "amdgpu" ];
    fprintd = {
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-elan;
    };
  };

  fileSystems = let
    root = "zroot/rocinante";
    persist = "zroot/persist";
  in {
    "/" = {
      device = "${root}/root";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

    "/nix" = {
      device = "${root}/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

    "/persist/etc" = {
      device = "${persist}/etc";
      fsType = "zfs";
      options = [ "zfsutil" ];
      neededForBoot = true;
    };

    "/boot" = {
      device = "/dev/disk/by-id/nvme-KINGSTON_SNV2S1000G_50026B7785953DEF-part1";
      fsType = "vfat";
      options = [ "dmask=0077" "fmask=0177" ];
    };
  };
}
