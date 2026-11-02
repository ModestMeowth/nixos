{ den, ... }:
{
  den.hosts.x86_64-linux.pwnyboy = {
    users.mm = { };
  };

  den.aspects.pwnyboy = {
    includes = with den.aspects; [
      profile.server
      hw.gpu.intel

      svc.cockpit
      svc.ncps
      virt.docker
    ];

    nixos =
      { config, ... }:
      let
        secrets = config.sops.secrets;
      in
      {
        hardware.facter = {
          enable = true;
          reportPath = ./facter.json;
        };

        boot = {
          initrd.availableKernelModules = [ "sr_mod" ];

          kernelModules = [
            "vfio_virqfd"
            "vfio_pci"
          ];

          kernelParams = [
            "intel_iommu=on"
            "iommu=pt"
            "i915.force_probe=!4692"
            "xe.force_probe=4692"
          ];
        };


        networking = {
          hostName = "pwnyboy";
          nameservers = [ "192.168.1.1" ];
          search = [ "threefinger.farm" ];
          useDHCP = false;

          bridges = {
            bridge0.interfaces = [ "enp3s0" ];

            bridge1.interfaces = [ "enp4s0" ];
          };

          interfaces = {
            enp3s0.wakeOnLan.enable = true;
            enp4s0.wakeOnLan.enable = true;
            bridge0.ipv4.addresses = [
              {
                address = "192.168.1.30";
                prefixLength = 24;
              }
            ];
          };

          defaultGateway = {
            address = "192.168.1.1";
            interface = "bridge0";
          };

          firewall = {
            allowedTCPPorts = [
              443
              2049
              8081
              8083
              8123

              8883
              22000
            ];

            allowedUDPPorts = [
              22000
              21027
            ];
          };
        };

        power.ups = {
          enable = true;
          mode = "netserver";
          openFirewall = true;

          upsd.listen = [
            { address = "0.0.0.0"; }
            { address = "::"; }
          ];

          users."ha".passwordFile = secrets."ha-nut-user".path;

          ups."network" = {
            driver = "usbhid-ups";
            description = "Networking UPS";
            port = "auto";
            directives = [
              "vendorid = 0764"
              "productid = 0501"
            ];
          };

          upsmon.monitor."network" = {
            system = "network@192.168.1.30";
            user = "ha";
            passwordFile = secrets."ha-nut-user".path;
          };
        };

        services = {
          cockpit.allowed-origins = [
            "https://pwnyboy:9090"
            "https://pwnyboy.threefinger.farm"
            "https://pwnyboy.cat-alkaline.ts.net:9090"
            "https://pwnyboy.com"
          ];

          pipewire.enable = false;

          nfs.server = {
            enable = true;
            exports = ''
              /persist/data/media -rw,subtree_check,root_squash *.cat-alkaline.ts.net *.threefinger.farm
            '';
          };

          sanoid.datasets = {
            "zroot/persist/home/mm".use_template = [ "default" ];
            "zroot/persist/home/root".use_template = [ "default" ];

            "persist/backups/emulation/saves".use_template = [ "default" ];
            "persist/backups/signal".use_template = [ "default" ];
            "persist/cloud/photos".use_template = [ "default" ];
            "persist/data".use_template = [ "default" ];

            "docker/config".use_template = [ "default" ];
          };
        };

        users.users.mm.extraGroups = [
          "libvirtd"
        ];
      };
  };
}
