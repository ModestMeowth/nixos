{
  config,
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  networking.hostName = "rocinante";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.disko
    ./disks.nix
    ] ++ (let p = ../../../modules/system; in [
      (p)
      (p + "/secureboot.nix")
      (p + "/gpu.nix")
      (p + "/pipewire.nix")
      (p + "/ssh.nix")
      (p + "/gnome.nix")
  ]);

  services = {
    fwupd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
    dig
    nmap
  ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr.icd
      ];
    };
  };

  services.xserver.videoDrivers = ["amdgpu"];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = ["amdgpu"];
    kernelModules = [
      "acpi_call"
      "kvm-amd"
    ];
    extraModulePackages =
      [
      ]
      ++ (with config.boot.kernelPackages; [
        acpi_call
      ]);

    kernelParams = [
      "quiet"
    ];
    consoleLogLevel = 0;

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub.enable = lib.mkForce false;
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      timeout = 3;
    };
  };
}
