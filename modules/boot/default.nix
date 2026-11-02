{
  den.aspects.boot = {
    nixos =
      { lib, pkgs, ... }:
      let
        inherit (lib) mkDefault mkForce;
      in
      {
        boot.loader = {
          efi = {
            canTouchEfiVariables = mkDefault true;
            efiSysMountPoint = "/boot";
          };

          grub.enable = mkForce false;
          systemd-boot.enable = mkForce false;

          limine = {
            enable = mkDefault true;
            maxGenerations = mkDefault 5;
            style.wallpapers = [ ];
          };
        };

        environment.systemPackages = [ pkgs.sbctl ];
      };
  };
}
