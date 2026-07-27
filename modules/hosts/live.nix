{ inputs, lib, ... }:
{
  den.aspects.live = {
    nixos =
      { modulesPath, pkgs, ... }:
      {
        imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        boot.supportedFilesystems.zfs = true;

        environment.systemPackages = with pkgs; [
          gptfdisk
          dosfstools
          e2fsprogs
          nixos-facter
          nvme-cli
          ripgrep
          tmux
          xfsprogs
        ];
      };

    environment.etc."nixos".source = lib.cleanSourceWith {
      name = "nixos-flake";
      src = inputs.self;
    };
  };
}
