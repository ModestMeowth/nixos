{
  den.aspects.desktop._.gnome = {
    nixos =
      { lib, pkgs, ... }:
      {
        services = {
          displayManager.gdm.enable = lib.mkForce true;
          desktopManager.gnome.enable = true;

          gnome = {
            core-apps.enable = false;
            core-os-services = true;
            games.enable = false;
          };
        };

        environment.gnome.excludePackages = with pkgs; [
          gnome-tour
          gnome-user-docs
        ];
      };
  };
}
