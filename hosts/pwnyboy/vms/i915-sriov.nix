{ config, lib, pkgs, ... }:
let
  deviceBDF = "0000:00:02.0";

  customKernel = pkgs.linux_latest.override {
    structuredExtraConfig = with lib.kernel; {
      DRM_I915_PXP = yes;
      INTEL_MEI_PXP = module;
    };
  };

  i915SRIOVModule = customKernelPackages.callPackage
    ({ stdenv, kernel }: stdenv.mkDerivation {
      pname = "i915-sriov-dkms";
      version = "2024.12.30";

      src = pkgs.fetchFromGitHub {
        owner = "strongtz";
        repo = "i915-sriov-dkms";
        rev = "master";
        sha256 = "sha256-FjNtEP8aewQeYyDgs+N0ZyI3OwgGfsFs2XB5KWGDvOY=";
      };

      nativeBuildInputs = kernel.moduleBuildDependencies ++ [ pkgs.xz ];

      makeFlags = [
        "KERNELRELEASE=${kernel.modDirVersion}"
        "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
      ];

      buildPhase = ''
        make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
        M=$(pwd) \
        KERNELRELEASE=${kernel.modDirVersion}
      '';

      installPhase = ''
        mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
        ${pkgs.xz}/bin/xz -z -f i915.ko
        cp i915.ko.xz $out/lib/modules/${kernel.modDirVersion}/extra/i915-sriov.ko.xz
      '';

      meta = with lib; {
        description = "Custom module for i915 SR-IOV support";
        homepage = "https://github.com/strongtz/i915-sriov-dkms";
        license = licenses.gpl2Only;
        platforms = platforms.linux;
      };
    })
    { };

  customKernelPackages = pkgs.linuxPackagesFor customKernel;
in
{
  boot.kernelPackages = customKernelPackages;
  boot.extraModulePackages = [ i915SRIOVModule ];

  boot.blacklistedKernelModules = [ "i915" ];

  boot.kernelModules = [ "i915-sriov" "mei_pxp" ];
  boot.initrd.kernelModules = [ "i915-sriov" ];

  boot.extraModprobeConfig = ''
    alias i915 i915-sriov
    options i915-sriov enable_guc=3 max_vfs=7
    softdep i915-sriov post: mei_pxp
  '';

  boot.postBootCommands = ''
    /run/current-system/sw/bin/depmod -a ${customKernel.modDirVersion}
  '';

  systemd.services."enable-SR-IOV" = {
    description = "SRIOV Graphics enablement";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.pciutils ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "enable-SR-IOV" #bash
        ''
          deviceBDF=${deviceBDF}
          IFS=" " read -ra lspciString <<< "$(lspci -s $deviceBDF -n)"
          if [ "''${lspciString[1]}"=="0300" ]; then
            IFS=":" read -ra vendorDevice <<< "''${lspciString[2]}"
            echo '0' | tee -a /sys/bus/pci/devices/$deviceBDF/sriov_drivers_autoprobe
            echo '7' | tee -a /sys/bus/pci/devices/$deviceBDF/sriov_numvfs
            echo '1' | tee -a /sys/bus/pci/devices/$deviceBDF/sriov_drivers_autoprobe
            echo "''${vendorDevice[0]} ''${vendorDevice[1]}" | tee -a /sys/bus/pci/drivers/vfio-pci/new_id
            chmod 0666 /dev/vfio/*
          else
            echo "The Device at $deviceBDF is no Graphics Card"
          fi
        '';
    };
  };
}
